#!/bin/bash

name=""
for FILE in $(git diff --name-only); do
    # 忽略检查的文件
    if [[ $FILE == *".sh"* ]] ; then
        continue
    elif [[ $FILE == *".md"* ]] ; then
        continue
    fi

    name="$name $FILE"
done

echo "-> Running 'flutter format' to check project dart style 🤓"

cd ..
RESULT=$(dartfmt -n "$name")

if [[ $? != 0 ]]; then
    echo "----> Command failed."
elif [[ $RESULT ]]; then
    echo "----> Some files are looking weird here 🤓:"
    echo "$RESULT"
    exit 1
else
    echo "----> All format is good ✅"
fi
