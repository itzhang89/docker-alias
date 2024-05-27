#!/bin/bash

# 下载 .docker_alias 文件
curl -LO https://raw.githubusercontent.com/itzhang89/docker-alias/main/.docker_alias

# 检查文件是否成功下载
if [ -f .docker_alias ]; then
    # 将其添加到 ~/.bashrc 中，并立即生效
    echo "[ -f ~/.docker_alias ] && source ~/.docker_alias" >> ~/.bashrc
    source ~/.bashrc
    echo "Docker aliases have been successfully added and sourced. restart the terminal or run the source ~/.bashrc in the terminal"
else
    echo "Failed to download .docker_alias file."
fi

