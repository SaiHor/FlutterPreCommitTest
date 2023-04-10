#!/bin/bash
flag=0
for FILE in $(git diff --name-only --cached); do
    # 忽略检查的文件
    if [[ $FILE == *".sh"* ]] ; then
        continue
    elif [[ $FILE == *".md"* ]] ; then
        continue
    fi

    RESULT=$(dartfmt -n "$FILE")
    if [[ $? != 0 ]]; then
        flag=2
    elif [[ $RESULT ]]; then
      echo "this file is not format:$FILE"
        flag=1
    fi
done

if [[ $flag == 2 ]]; then
    echo "----> Command failed."
elif [[ $flag == 1 ]]; then
    exit 1
else
    echo "----> All format is good "
fi
