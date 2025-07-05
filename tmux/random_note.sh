#!/usr/bin/env bash

MIN_WIDTH=80
CURRENT_WIDTH=$(tmux display -p '#{client_width}')

if [ "$CURRENT_WIDTH" -lt "$MIN_WIDTH" ]; then
  echo ""
  exit 0
fi

# Thay đổi đường dẫn ở đây cho đúng thư mục và tên file
LATEST_FILE=$(ls -1t ~/note/notes/dailies/*.md 2>/dev/null | head -n 1)

if [ -z "$LATEST_FILE" ]; then
  echo "📂 No todo file found."
  exit 0
fi

tasks=()
while IFS= read -r line; do
  tasks+=("$line")
done < <(awk '/^- \[ \] / {sub(/^- \[ \] /, ""); print}' "$LATEST_FILE")

if [ "${#tasks[@]}" -eq 0 ]; then
  echo "🎧 All done!"
else
  task="${tasks[RANDOM % ${#tasks[@]}]}"
  echo "⏰ $task"
fi
