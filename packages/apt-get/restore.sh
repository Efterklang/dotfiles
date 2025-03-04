#!/bin/bash

# 检查参数
if [ $# -ne 1 ]; then
    echo "用法: $0 <备份目录路径>"
    exit 1
fi

BACKUP_DIR="$1"

# 检查备份目录
if [ ! -d "$BACKUP_DIR" ]; then
    echo "错误: 备份目录 $BACKUP_DIR 不存在"
    exit 1
fi

# 恢复源
echo "恢复源列表..."
sudo cp "$BACKUP_DIR/sources.list" /etc/apt/sources.list
sudo cp -r "$BACKUP_DIR/sources.list.d/"* /etc/apt/sources.list.d/

# 恢复密钥
echo "恢复APT密钥..."
sudo apt-key add "$BACKUP_DIR/apt-keys.txt"

# 更新包数据库
echo "更新包数据库..."
sudo apt-get update

# 恢复包
echo "恢复已安装的包..."
sudo dpkg --set-selections < "$BACKUP_DIR/all-packages.txt"
sudo apt-get dselect-upgrade -y

echo "恢复完成!"