#!/bin/bash

name=""
for FILE in $(git diff --name-only --cached); do
    # 忽略检查的文件
    if [[ $FILE == *".sh"* ]] ; then
        continue
    elif [[ $FILE == *".md"* ]] ; then
        continue
    fi

    name="$name $FILE"
done

DARTFMT_OUTPUT=$(dartfmt -w  | grep Formatted)

if [ -n "$DARTFMT_OUTPUT" ]; then
  echo "$DARTFMT_OUTPUT"
  echo "Re-attempt commit."
  exit 1
else
  echo "All Dart files formatted correctly. Yay!"
  exit 0

fi
