#!/bin/bash

# 创建备份目录
BACKUP_DIR="$HOME/apt-backup-$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"

# 备份手动安装的包
echo "备份手动安装的包..."
apt-mark showmanual >"$BACKUP_DIR/manual-packages.txt"

# 备份所有包及其状态
echo "备份所有包及其状态..."
dpkg --get-selections >"$BACKUP_DIR/all-packages.txt"

# 备份源列表
echo "备份源列表..."
sudo cp /etc/apt/sources.list "$BACKUP_DIR/"
sudo cp -r /etc/apt/sources.list.d "$BACKUP_DIR/"

# 备份密钥
echo "备份APT密钥..."
sudo apt-key exportall >"$BACKUP_DIR/apt-keys.txt"

echo "备份完成! 文件保存在 $BACKUP_DIR"
