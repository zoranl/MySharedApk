#!/bin/sh

cd /d/mygit/MySharedApk/
rm com.zoranl.mymath-v1\(0.9b\)-debug.apk
git add com.zoranl.mymath-v1\(0.9b\)-debug.apk
git commit -m "mymath apk updates"
git push -u origin master

#curl https://github.com/zoranl/MySharedApk/raw/refs/heads/master/com.zoranl.mymath-v1(0.9b)-debug.apk

cp /d/androidWorkspace/MyMath/app/build/outputs/apk/debug/com.zoranl.mymath-v1\(0.9b\)-debug.apk /d/mygit/MySharedApk/
git add com.zoranl.mymath-v1\(0.9b\)-debug.apk;git commit -m "mymath apk updates";git push -u origin master;



