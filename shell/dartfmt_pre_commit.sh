#!/bin/bash

name=""
flag=0
for FILE in $(git diff --name-only); do
    # 忽略检查的文件
    if [[ $FILE == *".sh"* ]] ; then
        continue
    elif [[ $FILE == *".md"* ]] ; then
        continue
    fi

    dartfmt -n "$FILE"
    if [[ $? != 0 ]]; then
      flag=1
        echo "$FILE should format"
    fi
done

echo "-> Running 'flutter format' to check project dart style 🤓"


if [[ $flag == 0 ]]; then
    exit 0
elif [[ $flag == 1 ]]; then
    echo "$flag"
    exit 1
else
    echo "----> All format is good ✅"
fi
