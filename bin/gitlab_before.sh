#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
# repo_dir=$(git rev-parse --show-toplevel)
. "${script_dir}/functions"
git_modules=(psick puppet puppetserver grafanadash)
git_branch=${1:-development}
default_branch="production"
r10k_configfile="bin/config/gitlab-runner-r10k.yaml"
# Location of keys to copy into the local repository (removed from gilab_after.sh
eyamlkeyloc=$2

if [ -f "$eyamlkeyloc" ]; then
  echo "Setup keys"
  mkdir -p ${repo_dir}/keys
  cp -f ${eyamlkeyloc}/* ${repo_dir}/keys/
fi

if [ -f "$r10k_configfile" ]; then
  config="-c ${r10k_configfile}"
fi
echo

cd $repo_dir

diff_commits_number=$(git log origin/$default_branch..HEAD --pretty=oneline | wc -l)
echo "Checking if Puppetfile has changed in the last ${diff_commits_number} commits"
for changedfile in $(git diff HEAD~$diff_commits_number --name-only); do
  if [[ "x$changedfile" == 'xPuppetfile' ]] || [ ! -d "${repo_dir}/modules/stdlib" ]; then
    echo_title "Detected change in Puppetfile. Resyncing modules."
    for d in modules/*/.git; do (cd $d/.. && git status >/dev/null); done
    echo_title "Installing external modules via r10k"
    /opt/puppetlabs/puppet/bin/r10k puppetfile install -v ${config}
  fi
done
