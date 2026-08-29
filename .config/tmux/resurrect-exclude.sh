#!/usr/bin/env bash
# tmux-resurrect post-save-layout hook: strip any session named in the
# @resurrect-exclude-sessions option out of the just-written save file, so
# it's never restored -- even though it's still alive and gets re-saved
# (and re-stripped) on every subsequent autosave.
#
# Usage: tmux set -g @resurrect-exclude-sessions "scratch some-other-name"
# (space-separated exact session names)

resurrect_file="$1"
[ -f "$resurrect_file" ] || exit 0

excluded="$(tmux show-option -gv @resurrect-exclude-sessions 2>/dev/null)"
[ -z "$excluded" ] && exit 0

tmp="$(mktemp)"
cp "$resurrect_file" "$tmp"
for name in $excluded; do
  # resurrect lines are tab-separated: <type><TAB><session_name><TAB>...
  # ("state" and plain "grouped_session" header lines have no session-name
  # field in that position, so they pass through untouched)
  awk -F'\t' -v s="$name" \
    '!(($1=="pane" || $1=="window" || $1=="grouped_session") && $2==s)' \
    "$tmp" > "$resurrect_file"
  cp "$resurrect_file" "$tmp"
done
rm -f "$tmp"
