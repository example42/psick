#!/bin/bash
ENVDIR='/etc/puppetlabs/code/environments'
ENVSTAGEDIR='/etc/puppetlabs/code-developers'  # Custom dir used for developers environments
if [ -x /usr/bin/git ]; then
  if [ -d "${ENVSTAGEDIR}/$1/.git" ]; then
    ENVGITDIR="${ENVSTAGEDIR}/$1/.git"
  else
    ENVGITDIR="${ENVDIR}/$1/.git"
  fi
  /usr/bin/git --git-dir "${ENVGITDIR}" log --pretty=format:"%h - %an, %ad : %s" -1
else
  echo "no git - environment ${1}"
fi
exit 0
