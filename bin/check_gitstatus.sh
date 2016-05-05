#!/bin/bash
echo "### Main puppet-module repo"
git status

for mod in $(ls -1 modules); do
  echo
  echo "### ${mod}"
  cd modules/$mod
  git status
  git branch
  cd ../../
done
