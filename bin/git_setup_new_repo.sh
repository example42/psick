#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
git_remote=$(git remote get-url origin)
parent_dir=`cd $repo_dir ; cd .. ; pwd`

echo_title "Creating a brand new control-repo based on this one"
echo
echo_subtitle "A new directory will be created under ${parent_dir}"
if [ -z $1 ]; then
	echo -n "Enter the new control-repo directory name and press [ENTER]: "
	read new_repo_name
else
	new_repo_name=$1
fi

new_repo_dir="${parent_dir}/${new_repo_name}"
echo_subtitle "Copying files from the current repo to ${new_repo_dir}"
rsync -a --exclude='.git' --exclude='.vagrant' $repo_dir/ $new_repo_dir

echo_subtitle "Initialising git in the new directory"
cd $new_repo_dir
git init
git checkout -b production 2>/dev/null
git branch -d master 2>/dev/null
echo_subtitle "Showing current status of the new git repo"
git status

echo_subtitle "NOTE: master branch has been renamed to production for Puppet compliance"
echo
echo_subtitle "Do you want to make a first commit on the new repo?"
echo "Press 'y' to commit all the existing files so to have a snapshot of the current repo"
echo "Press anything else to skip this and take your time to review and cleanup files before your first commit"
read press
case $press in
  y) git add . ; git commit -m "First commit: Snapshot of ${git_remote}" ;;
  *) echo_subtitle "Nothing has been committed now"
esac

echo_title "Congratulations! Setup of the new control-repo finished"
echo_subtitle "To start to work on it: cd ${new_repo_dir}"
