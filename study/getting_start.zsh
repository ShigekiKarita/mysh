#!/usr/bin/env zsh

# 変数
myvar=こんにちは

# 出力
echo $myvar
printf "初めて: %s, %s\n" hello world

# trace オプション
set -x                          # 有効化
echo trace on
echo trace on2
set +x                          # 無効化
echo trace off
