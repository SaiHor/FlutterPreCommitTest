#!/bin/bash
echo "pre-main hook 运行了"
for FILE in $(git diff --name-only --cached); do
    # 忽略检查的文件
    if [[ $FILE == *".sh"* ]] ; then
        continue
    elif [[ $FILE == *".md"* ]] ; then
        continue
    fi

    exec dartfmt -w $FILE
done
exit
