#!/bin/bash

hooks_repo='https://github.com/drwahl/puppet-git-hooks'
if [ $1 ]; then
  hooks_repo=$1
fi

main_dir=$(git rev-parse --show-toplevel)

echo "Executing: git clone ${hooks_repo} /var/tmp/"
git clone ${hooks_repo} /var/tmp/puppet-git-hooks

echo "Copying /var/tmp/puppet-git-hooks/commit_hooks in ${main_dir}/.git/hooks"
cp -rvpn /var/tmp/puppet-git-hooks/commit_hooks "${main_dir}/.git/hooks"

echo "Copying /var/tmp/puppet-git-hooks/pre-commit in ${main_dir}/.git/hooks"
cp -rvpn /var/tmp/puppet-git-hooks/pre-commit "${main_dir}/.git/hooks"

echo
echo "Git hooks from ${hooks_repo}"
echo "are now installed in your ${main_dir}/.git/hooks"
echo
echo "They will be used on git operations, configure them by editing ${main_dir}/.git/hooks/config.cfg"

