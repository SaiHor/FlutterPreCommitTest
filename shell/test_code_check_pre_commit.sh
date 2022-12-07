#!/bin/bash
echo "pre-main hook 运行了"
for FILE in `git diff --name-only --cached`; do
    # 忽略检查的文件
    if [[ $FILE == *".sh"* ]] ; then
        continue
    fi

    # 拦截特定的类
    # if [[ $FILE == *"AppDelegate.m"* ]] ; then
    #     echo -e $FILE '拦截到了AppDelegate'
    #     exit 1
    # fi

    # 匹配不能上传的关键字
    grep 'TestCode \| ttt' --ignore-case $FILE 2>&1 >/dev/null
    if [ $? -eq 0 ]; then
        # 将错误输出
        echo -e $FILE '文件中包含了TODO、debugger、alert其中一个关键字请删除后再提交'
        exit 1
    fi
done
exit
