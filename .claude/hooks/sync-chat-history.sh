#!/bin/bash
# Copies the current Claude Code transcript into <project>/.chat-history after every turn.
input=$(cat)
transcript=$(printf '%s' "$input" | /usr/bin/python3 -c 'import sys,json; print(json.load(sys.stdin).get("transcript_path",""))')
session=$(printf '%s' "$input" | /usr/bin/python3 -c 'import sys,json; print(json.load(sys.stdin).get("session_id","session"))')
[ -f "$transcript" ] || exit 0
dest="${CLAUDE_PROJECT_DIR:-$PWD}/.chat-history"
mkdir -p "$dest"
cp "$transcript" "$dest/$session.jsonl"
exit 0
