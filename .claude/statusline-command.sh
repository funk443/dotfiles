#!/bin/sh
# Claude Code status line
# Shows: cwd (last dir only){session name}, model, context window usage %,
#        session usage % + reset time

input=$(cat)

cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty')
cwd_name=$(basename "$cwd" 2>/dev/null)

model=$(printf '%s' "$input" | jq -r '.model.display_name // empty')

ctx_pct=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')

session_pct=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
session_reset=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')

reset_str=""
if [ -n "$session_reset" ]; then
  case "$session_reset" in
    *[!0-9]*) reset_str=$(date -d "$session_reset" "+%H:%M" 2>/dev/null) ;;
    *) reset_str=$(date -d "@$session_reset" "+%H:%M" 2>/dev/null || date -r "$session_reset" "+%H:%M" 2>/dev/null) ;;
  esac
fi

out="$cwd_name"
[ -n "$model" ] && out="$out | $model"
if [ -n "$ctx_pct" ]; then
  out="$out | $(printf '%.0f' "$ctx_pct")%"
fi
if [ -n "$session_pct" ]; then
  if [ -n "$reset_str" ]; then
    out="$out | $(printf '%.0f' "$session_pct")% ($reset_str)"
  else
    out="$out | $(printf '%.0f' "$session_pct")%"
  fi
fi

printf '%s' "$out"
