#!/bin/bash
# ステータスバー用: 全セッションを「番号:名前」形式で表示
# 現在のセッションは強調（水色背景）
# 番号は作成時刻順（アルファベット順ではない）
current="${1:-}"
num=1
while IFS= read -r line; do
    name="${line#*:}"
    if [ "$name" = "$current" ]; then
        printf '#[bg=#89b4fa,fg=#1e1e2e,bold] %d:%s #[bg=#1e1e2e,fg=#89b4fa,nobold]' "$num" "$name"
    else
        printf '#[fg=#6c7086] %d:%s ' "$num" "$name"
    fi
    num=$((num + 1))
done < <(tmux ls -F '#{session_created}:#{session_name}' 2>/dev/null | sort -n)
