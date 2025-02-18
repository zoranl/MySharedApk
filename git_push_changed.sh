#!/bin/bash


current_branch=$(git rev-parse --abbrev-ref HEAD)
echo 
echo !!!!current branch:$current_branch
echo 

if [[ $current_branch != master ]]; then
	echo !!!!not on master branch!!!!
	exit
fi

git status

changed_files=$(git diff --name-only --no-color)

echo !!!!changed files:"|$changed_files|"

if [[ -z $changed_files ]]; then
	echo !!!!no files changed!!!!
	exit
fi

echo
echo !!!!changed files:$changed_files
echo

git add $changed_files

git commit -m "updating changed files"
git push -u origin master