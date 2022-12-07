#!/bin/bash
echo "pre-main hook 运行了"
for FILE in $(git diff --name-only --cached); do
    # 忽略检查的文件
    if [[ $FILE == *".sh"* ]] ; then
        continue
    fi


    grep '///' $FILE 2>&1 >/dev/null
    if [ $? -eq 0 ]; then
        # 将错误输出
        echo -e $FILE '文件中包含了TODO、debugger、alert其中一个关键字请删除后再提交'
        exit 1
    fi
done
exit
