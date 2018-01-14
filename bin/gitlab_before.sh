#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
# repo_dir=$(git rev-parse --show-toplevel)
. "${script_dir}/functions"
PATH=/opt/puppetlabs/puppet/bin:$PATH
git_branch=${1:-integration}
default_branch="production"
ci=$(echo $0 | sed 's/_before\.sh//g' | sed 's/^bin\///g')
r10k_configfile="bin/config/${ci}-r10k.yaml"
# Location of keys to copy into the local repository (removed from_after.sh
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
git config --add remote.origin.fetch +refs/heads/$default_branch:refs/remotes/origin/$default_branch
git fetch --no-tags
diff_commits_number=$(git log origin/$default_branch..HEAD --pretty=oneline | wc -l)
echo "Deploying modules via r10k if Puppetfile has changed in the last ${diff_commits_number} commits"
commits=$(git diff HEAD~$diff_commits_number --name-only | wc -l)
if [ $commits -gt 0 ]; then
  changedfiles=$(git diff HEAD~$diff_commits_number --name-only | grep Puppetfile);
  if [ "x$changedfiles" == "xPuppetfile" ] || [ ! -d "${repo_dir}/modules/stdlib" ] ; then
    echo_title "Installing modules defined in Puppetfile via r10k"
    r10k puppetfile install -v ${config}
  fi
fi
