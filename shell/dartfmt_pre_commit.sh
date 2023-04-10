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
    echo "$FILE:$FILE"
done

nameR=$("$name" | grep -o "[^ ]\+\( \+[^ ]\+\)*")
echo "name:$nameR"

RESULT=$(dartfmt -n "$nameR")

if [[ $? != 0 ]]; then
    echo "----> Command failed."
elif [[ $RESULT ]]; then
    echo "----> Some files are looking weird here 🤓:"
    echo "$RESULT"
    exit 1
else
    echo "----> All format is good ✅"
fi
