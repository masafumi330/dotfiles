#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
EFFORT=$(echo "$input" | jq -r '.effort.level // ""')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
RL_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
RL_7D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0' | cut -d. -f1)
RL_5H_RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // 0')
RL_7D_RESET=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // 0')

CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
RESET='\033[0m'

# Pick bar color based on context usage
if [ "$PCT" -ge 90 ]; then
  BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then
  BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

make_bar() {
  local pct=$1 filled empty fill pad
  filled=$((pct / 10))
  empty=$((10 - filled))
  printf -v fill "%${filled}s"
  printf -v pad "%${empty}s"
  echo "${fill// /█}${pad// /░}"
}

BAR=$(make_bar "$PCT")
BAR_5H=$(make_bar "$RL_5H")
BAR_7D=$(make_bar "$RL_7D")

MINS=$((DURATION_MS / 60000))
SECS=$(((DURATION_MS % 60000) / 1000))

BRANCH=""
GIT_STATUS=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  BRANCH=" | 🌿 $(git branch --show-current 2>/dev/null)"
  STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
  MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
  [ "$STAGED" -gt 0 ] && GIT_STATUS="${GREEN}+${STAGED}${RESET}"
  [ "$MODIFIED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${YELLOW}~${MODIFIED}${RESET}"
fi

format_remaining() {
  local reset_at=$1
  local now
  now=$(date +%s)
  if [ "$reset_at" -le 0 ] 2>/dev/null || [ "$reset_at" = "null" ]; then
    echo "--:--"
    return
  fi
  local diff=$((reset_at - now))
  if [ "$diff" -le 0 ]; then
    echo "00:00"
    return
  fi
  local h=$((diff / 3600))
  local m=$(((diff % 3600) / 60))
  printf "%02d:%02d" "$h" "$m"
}

REMAIN_5H=$(format_remaining "$RL_5H_RESET")
REMAIN_7D=$(format_remaining "$RL_7D_RESET")

MODEL_DISPLAY="$MODEL"
[ -n "$EFFORT" ] && MODEL_DISPLAY="$MODEL/$EFFORT"
echo -e "${CYAN}[$MODEL_DISPLAY]${RESET}  ${DIR##*/}${BRANCH} ${GIT_STATUS}"
COST_FMT=$(printf '$%.2f' "$COST")
echo -e "${BAR_COLOR}${BAR}${RESET} ${PCT}% | ${BAR_COLOR}${BAR_5H}${RESET} ${RL_5H}% (reset ${REMAIN_5H})/5h | ${BAR_COLOR}${BAR_7D}${RESET} ${RL_7D}% (reset ${REMAIN_7D})/7d"
