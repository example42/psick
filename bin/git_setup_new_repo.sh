#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
git_remote=$(git remote -v | grep origin)
parent_dir=$(cd $repo_dir ; cd .. ; pwd)

echo_title "PSICK is going to create a brand new control-repo"
echo
echo_subtitle "Specify the path where you want to create it"
if [ -z $1 ]; then
	echo "Provide the full absolute path or the name of a dir that will be created under ${parent_dir}"
        echo "Press [ENTER] when done."
	read new_repo_name
else
	new_repo_name=$1
fi
echo $new_repo_name | grep "^/"
if [ $? == 0 ]; then
new_repo_dir=$new_repo_name
else 
new_repo_dir="${parent_dir}/${new_repo_name}"
fi

ask_choice () {
  echo_subtitle "Choose how you want to start with your new control-repo"
  echo "1- Create a full featured control-repo based on current PSICK"
  echo "2- Clone the Puppet default one: https://github.com/puppetlabs/control-repo"
  echo "Note that you will be able to add or remove components later."
  echo "Make your choice:"
  read which_controlrepo

  case $which_controlrepo in
    1) setup_psick ;;
    2) setup_default ;;
    *) ask_choice ;;
  esac
}

setup_psick () {
  echo_subtitle "Copying all files from psick to ${new_repo_dir}"
  mkdir -p $new_repo_dir
  rsync -a --exclude='.git' --exclude='.vagrant' --exclude='.pe_build' $repo_dir/ $new_repo_dir/

  git_init
  end_message
}
setup_default () {
  echo_subtitle "Cloning https://github.com/puppetlabs/control-repo into ${new_repo_dir}"
  git clone https://github.com/puppetlabs/control-repo $new_repo_dir
  end_message
}

git_init () {
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
}

end_message () {
  echo_title "Congratulations! Setup of the new control-repo finished"
  echo_subtitle "To start to work on it:"
  echo_subtitle "cd ${new_repo_dir}"
}

ask_choice
