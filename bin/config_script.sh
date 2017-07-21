#!/bin/bash
if [ -x /usr/bin/git ]; then
  /usr/bin/git --git-dir /etc/puppetlabs/code/environments/$1/.git log --pretty=format:"%h - %an, %ad : %s" -1
else
  echo "no git - environment $1"
fi
