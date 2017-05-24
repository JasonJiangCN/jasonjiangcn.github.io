#!/bin/zsh

cd ~/Documents/blog
hexo g
git add --all
nameUp="`date +%y%m%d`_updated" 
git commit -m  $nameUp
git push origin jason

cd public
git add --all
git commit -m  $nameUp
git push origin master
