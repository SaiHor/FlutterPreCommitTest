#!/bin/bash
echo "test_code_check_pre_commit.sh 运行了"
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
cd ..
exec dartfmt -w "name"
exit