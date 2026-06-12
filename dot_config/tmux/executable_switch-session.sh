#!/bin/bash
# Cmd+<数字> でセッション番号指定移動
# 引数: 1始まりのセッション番号（作成時刻順）
n=$1
session=$(tmux ls -F '#{session_created}:#{session_name}' 2>/dev/null \
    | sort -n \
    | awk -F: -v n="$n" 'NR == n { print $2 }')
[ -n "$session" ] && tmux switch-client -t "$session"
