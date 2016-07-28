#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

echo_title "We are going to create a new control-repo based on the current one"

echo_subtitle "Find it in the directory that contains this control repo"
if [ -z $1 ]; then
	echo -n "Enter the new control-repo directory name and press [ENTER]: "
	read new_repo_name
else
	new_repo_name=$1
fi

parent_dir=`cd $repo_dir ; cd .. ; pwd`
new_repo_dir="${parent_dir}/${new_repo_name}"
echo_title "Copying the repo files in ${new_repo_dir}"

rsync -a --exclude='.git' --exclude='.vagrant' $repo_dir/ $new_repo_dir

echo_title "Initialising git and moving into new directory"
cd $new_repo_dir
git init

git checkout -b production 2>/dev/null
git branch -d master 2>/dev/null
echo_subtitle "Note that git has been initialised and framed to be used with r10k:"
echo_subtitle "master branch has been removed and production has been created"
echo_subtitle "Commit now to have an exact snapshot of the upstream repo or clean up first what you want"

git status

echo_subtitle "To move into the new control-repo: cd ${new_repo_dir}"

