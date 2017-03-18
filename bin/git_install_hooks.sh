#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

hooks_repo='https://github.com/drwahl/puppet-git-hooks'
if [ $1 ]; then
  hooks_repo=$1
fi

main_dir=$(git rev-parse --show-toplevel)

echo_title "Executing: git clone ${hooks_repo} /var/tmp/"
git clone ${hooks_repo} /var/tmp/puppet-git-hooks

echo_title "Copying /var/tmp/puppet-git-hooks/commit_hooks in ${main_dir}/.git/hooks"
cp -rvpn /var/tmp/puppet-git-hooks/commit_hooks "${main_dir}/.git/hooks"

echo_title "Copying /var/tmp/puppet-git-hooks/pre-commit in ${main_dir}/.git/hooks"
cp -rvpn /var/tmp/puppet-git-hooks/pre-commit "${main_dir}/.git/hooks"

echo
echo_subtitle "Installed hooks from ${hooks_repo} to ${main_dir}/.git/hooks"
echo
echo "They will be used on git operations. Mostly in the pre-commit phase"

echo_title "Configure the tests to run hooks by editing ${main_dir}/.git/hooks/commit_hooks/config.cfg"
echo "You may prefer to set CHECK_PUPPET_LINT='permissive' to avoid commit block on Puppet lint errors"

