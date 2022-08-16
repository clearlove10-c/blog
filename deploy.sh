#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

dist_path=docs/.vuepress/dist # 打包生成的文件夹路径
npm run build # 生成静态文件
# 进入生成的文件夹
cd $dist_path

if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:clearlove10-c/blog.git
else
  msg='来自github action的自动部署'
  githubUrl=https://clearlove10-c:${GITHUB_TOKEN}@github.com/clearlove10-c/blog.git
  git config --global user.name "smlz"
  git config --global user.email "1162914749@qq.com"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github


cd -
rm -rf $dist_path
