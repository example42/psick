#!/usr/bin/env bash
BASEDIR=$(dirname $(readlink -f  "$0"))

showhelp() {
cat <<HELP
This script repopulates GitLab projects (and other useful stuff) based on the configuration file gitlab_populate.conf
and the Puppetfile configured them.
The lookup order for the configuration file is cwd, $HOME/gitlab_populate.conf and then /etc/gitlab_populate.conf.

All actions are idempotent.

Usage: ${0} <action>

Available actions:
  create_groups    - Create groups on $destination_giturl based on $puppetfile_file
  create_projects  - Create projects on $destination_giturl based on $puppetfile_file + $controlrepo_path controlrepo
  delete_projects  - Remove projects on $destination_giturl based on $puppetfile_file + $controlrepo_path controlrepo (DANGER)
  pull_modules     - Clone or pull $puppetfile_file repos from $source_giturl
  push_modules     - Push $puppetfile_file repos to $destination_giturl
  sync_modules     - Pull and push git repos
  pull_controlrepo - Clone or pull $controlrepo_path controlrepo from $source_giturl
  push_controlrepo - Push $controlrepo_path controlrepo to $destination_giturl
  sync_controlrepo - Pull and push controlrepo
  do_everything    - Do all the above actions (except delete_projects), in the listed order (idempotent)
  make_coffee      - Action unavailable. Help yourself.

Example: $0 do_everything

HELP
}

# We prefer to live in Puppet space
export PATH=/opt/puppetlabs/puppet/bin:$PATH

global_exit=0
set -o allexport
# Source config file
if [ -f gitlab_populate.conf ]; then
  . gitlab_populate.conf
elif  [ -f $HOME/gitlab_populate.conf ]; then
  . $HOME/gitlab_populate.conf
elif  [ -f /etc/gitlab_populate.conf ]; then
  . /etc/gitlab_populate.conf
else
  echo "Haven't found gitlab_populate.conf in $(pwd), ${HOME}/gitlab_populate.conf or /etc/gitlab_populate.conf"
  exit 1
fi
set +o allexport

if [ "$#" = "0" ] ; then
  showhelp
  exit
fi

check_git () {
  which git > /dev/null 2>&1
  if [ $? != 0 ]; then
    echo "You need to install git to perform this function"
    exit 1
  fi
}

check_gitlab () {
  which gitlab > /dev/null 2>&1
  if [ $? != 0 ]; then
    echo "You need to install gitlab gem to perform this function"
    exit 1
  fi
}

create_groups () {
  echo
  echo
  echo "### CREATING GROUPS ON GITLAB - Endpoint: ${GITLAB_API_ENDPOINT}"
  # Controlrepo
  group_name=$(echo $controlrepo_path | cut -d '/' -f 1 )
  group_path=$(echo $controlrepo_path | cut -d '/' -f 1 )
  echo
  echo "# Controlrepo ${controlrepo_path} - Group name and path: ${group_name}"
  gitlab groups "per_page: 5000" --only=full_path | grep "${group_path}" > /dev/null
  if [ $? == 0 ]; then
    echo "Group ${group_path} already exists :-)"
  else
    gitlab create_group "${group_name}" "${group_path}" > /dev/null && echo "Group ${group_path} created! :-)"
  fi  

  # Modules
  while read g
  do
    source_url=$g
    project_path=${g/$source_giturl/}
    group_name=$(echo $project_path | cut -d '/' -f 1 )
    group_path=$(echo $project_path | cut -d '/' -f 1 )
    echo
    echo "# Module: ${project_path} - Group name and path: ${group_path}"
    gitlab groups "per_page: 5000" --only=full_path | grep "${group_path}" > /dev/null
    if [ $? == 0 ]; then
      echo "Group ${group_path} already exists :-)"
    else
      gitlab create_group "${group_name}" "${group_path}" > /dev/null && echo "Group ${group_path} created! :-)"
    fi
   done < <(cat $puppetfile_file | grep ":git"  | grep -v "#" | cut -d "'" -f 2 | sed -e "s/\.git$//")
}

create_projects () {
  echo
  echo
  echo "### CREATING PROJECTS ON GITLAB - Endpoint: ${GITLAB_API_ENDPOINT}"

  # Controlrepo
  project_namespace=$(echo "$controlrepo_path" | cut -d '/' -f 1)
  project_name=$(echo "$controlrepo_path" | cut -d '/' -f 2)
  project_namespace_id=$(gitlab namespaces --only=path,id | grep "| ${project_namespace} " |  cut -d '|' -f 2 | sed 's/ //g')
  echo
  echo "# Project path: ${controlrepo_path} - Project name: ${project_name} - Namespace ID: ${project_namespace_id}"
  gitlab projects "per_page: 5000" --only=path_with_namespace | grep "$controlrepo_path" > /dev/null
  if [ $? == 0 ]; then
    echo "Project $controlrepo_path already exists :-)"
  else
    gitlab create_project "$project_name" "namespace_id: $project_namespace_id" > /dev/null && echo "Project $project_path created! :-)"
  fi
  
  # Modules
  while read g
  do
    source_url=$g
    project_path=${g/$source_giturl/}
    project_namespace=$(echo "$project_path" | cut -d '/' -f 1)
    project_name=$(echo "$project_path" | cut -d '/' -f 2)
    project_namespace_id=$(gitlab namespaces --only=path,id | grep "| ${project_namespace} " |  cut -d '|' -f 2 | sed 's/ //g')
    echo
    echo "# Project path: ${project_path} - Project name: ${project_name} - Namespace ID: ${project_namespace_id}"
    gitlab projects "per_page: 5000" --only=path_with_namespace | grep "$project_path" > /dev/null
    if [ $? == 0 ]; then
      echo "Project $project_path already exists :-)"
    else
      gitlab create_project "$project_name" "namespace_id: $project_namespace_id" > /dev/null && echo "Project $project_path created! :-)"
    fi
  done < <(cat $puppetfile_file | grep ":git"  | grep -v "#" | cut -d "'" -f 2 | sed -e "s/\.git$//")
}

delete_projects () {
  echo
  echo "DANGER ZONE! You requested to remove projects from ${GITLAB_API_ENDPOINT}! If you continue we will remove:"
  echo "- The control repo ${controlrepo_path}"
  echo "- All the modules listed in ${puppetfile_file}"
  echo
  echo "Are you sure you want to do this?!"
  echo "- [y] to proceed"
  echo "- [ENTER] or any other key to abort (DEFAULT)"
  read -p "Your choice: " answer
  answer=${answer:-n}
  if [ $answer != 'y' ]; then
    echo "Exiting. No changes were done. Stay safe"
    exit
  fi  
  echo
  echo
  echo "### REMOVING ALL PROJECTS ON GITLAB  ${GITLAB_API_ENDPOINT} (Controlrepo + modules in Puppetfile)!!!"

  # Controlrepo
  project_namespace=$(echo "$controlrepo_path" | cut -d '/' -f 1)
  project_name=$(echo "$controlrepo_path" | cut -d '/' -f 2)
  project_namespace_id=$(gitlab namespaces --only=path,id | grep "| ${project_namespace} " |  cut -d '|' -f 2 | sed 's/ //g')
  echo
  echo "# Project path: ${controlrepo_path} - Project name: ${project_name} - Namespace ID: ${project_namespace_id}"
  gitlab projects "per_page: 5000" --only=path_with_namespace | grep "$controlrepo_path" > /dev/null
  if [ $? == 0 ]; then
    yes | gitlab delete_project "$controlrepo_path"
  else
    echo "Project $controlrepo_path already missing :-!"
  fi
  
  # Modules
  while read g
  do
    source_url=$g
    project_path=${g/$source_giturl/}
    project_namespace=$(echo "$project_path" | cut -d '/' -f 1)
    project_name=$(echo "$project_path" | cut -d '/' -f 2)
    project_namespace_id=$(gitlab namespaces --only=path,id | grep "| ${project_namespace} " |  cut -d '|' -f 2 | sed 's/ //g')
    echo
    echo "# Project path: ${project_path} - Project name: ${project_name} - Namespace ID: ${project_namespace_id}"
    gitlab projects "per_page: 5000" --only=path_with_namespace | grep "$project_path" > /dev/null
    if [ $? == 0 ]; then
      yes | gitlab delete_project "$project_path"
    else
      echo "Project $project_path already missing :-!"
    fi
  done < <(cat $puppetfile_file | grep ":git"  | grep -v "#" | cut -d "'" -f 2 | sed -e "s/\.git$//")
}


pull_modules () {
  echo
  echo
  echo "### CLONING OR PULLING GIT REPOS from ${source_giturl}"
  mkdir -p $workdir
  while read g
  do
    cd $workdir
    source_url=$g
    project_path=${g/$source_giturl/}
    project_name=$(echo "$project_path" | cut -d '/' -f 2)
    echo
    echo "# Project path: ${project_path} - Project name: ${project_name} - Source: URL: ${source_url}"
    if [ -d $project_name ]; then
      cd $project_name
      git config pull.ff only
      initial_branch=$(git rev-parse --abbrev-ref HEAD)
      git fetch

      for remote in $(git branch --all | grep '^\s*remotes/origin' | grep -v 'HEAD' | grep -v "$initial_branch$" ); do
        branch=$(echo $remote | cut -d '/' -f 3) &>/dev/null
        git branch -l | grep "$branch" || git checkout --track $remote &>/dev/null
      done
      git checkout $initial_branch &>/dev/null
      git pull

      # Add destination remote
      git remote -v | grep destination &>/dev/null
      if [ $? != 0 ]; then
        git remote add destination "${destination_giturl}${project_path}"
      fi

      cd ..
    else
      git clone "${source_giturl}${project_path}"
      cd $project_name
      initial_branch=$(git rev-parse --abbrev-ref HEAD)
      git remote add destination "${destination_giturl}${project_path}"
      for remote in $(git branch --all | grep '^\s*remotes/origin' | grep -v 'HEAD' | grep -v "$initial_branch$" ); do
        branch=$(echo $remote | cut -d '/' -f 3) &>/dev/null
        git branch -l | grep "$branch" || git checkout --track $remote &>/dev/null
      done
      git checkout $initial_branch &>/dev/null

      cd ..
    fi
    cd ..
  done < <(cat $puppetfile_file | grep ":git"  | grep -v "#" | cut -d "'" -f 2 | sed -e "s/\.git$//")
}

push_modules () {
  echo
  echo
  echo "### PUSHING GIT REPOS to ${destination_giturl}"
  mkdir -p $workdir
  cd $workdir
  while read g
  do
    source_url=$g
    project_path=${g/$source_giturl/}
    project_name=$(echo "$project_path" | cut -d '/' -f 2)
    echo
    echo "# Project path: ${project_path} - Project name: ${project_name}"
    if [ -d $project_name/.git ]; then
      cd $project_name
      git push --all destination 
      git push --tags destination
      cd ..
    else
      echo "Missing git repo in ${workdir}/${project_name}"
    fi
  done < <(cat $puppetfile_file | grep ":git"  | grep -v "#" | cut -d "'" -f 2 | sed -e "s/\.git$//")
}

pull_controlrepo() {
  echo
  echo
  echo "### CLONING OR PULLING CONTROL-REPO from ${source_giturl}"
  mkdir -p $workdir
  cd $workdir
  source_url="${source_giturl}${controlrepo_path}"
  project_path=$controlrepo_path
  project_name=$(echo "$project_path" | cut -d '/' -f 2)
  echo
  echo "# Controlrepo path: ${project_path} - Project name: ${project_name} - Source: URL: ${source_url}"
  if [ -d $project_name ]; then
    cd $project_name

    initial_branch=$(git rev-parse --abbrev-ref HEAD)
    git config pull.ff only
    git fetch
    for remote in $(git branch --all | grep '^\s*remotes/origin' | grep -v 'HEAD' | grep -v "$initial_branch$" ); do
      branch=$(echo $remote | cut -d '/' -f 3) &>/dev/null
      git branch -l | grep "$branch" || git checkout --track $remote &>/dev/null
    done
    git checkout $initial_branch &>/dev/null
    git pull

    # Add destination remote
    git remote -v | grep destination > /dev/null
    if [ $? != 0 ]; then
      git remote add destination "${destination_giturl}${project_path}"
    fi    

    cd ..
  else
    git clone "${source_giturl}${project_path}"
    cd $project_name
    initial_branch=$(git rev-parse --abbrev-ref HEAD)
    git remote add destination "${destination_giturl}${project_path}"
    for remote in $(git branch --all | grep '^\s*remotes/origin' | grep -v 'HEAD' | grep -v "$initial_branch$" ); do
      branch=$(echo $remote | cut -d '/' -f 3) &>/dev/null
      git branch -l | grep "$branch" || git checkout --track $remote &>/dev/null
    done
    git checkout $initial_branch &>/dev/null

    cd ..
  fi
  cd ..
}

push_controlrepo () {
  echo
  echo
  echo "### PUSHING CONTROL-REPO to ${destination_giturl}"
  mkdir -p $workdir
  cd $workdir
  source_url="${source_giturl}${controlrepo_path}"
  project_path=$controlrepo_path
  project_name=$(echo "$project_path" | cut -d '/' -f 2)
  echo
  echo "# Controlrepo path: ${project_path} - Project name: ${project_name}"
  if [ -d $project_name/.git ]; then
    cd $project_name
    git push --all destination 
    git push --tags destination
    cd ..
  else
    echo "Missing git repo in ${workdir}/${project_name}"
  fi
}

run_action () {
  $1
  if [ $? != 0 ]; then
    global_exit=1
  fi
}

while [ $# -gt 0 ]; do
  case "$1" in
    create_groups)
      check_gitlab
      run_action create_groups
      shift
    ;;
    create_projects)
      check_gitlab
      run_action create_projects
      shift
    ;;
    delete_projects)
      check_gitlab
      run_action delete_projects
      shift
    ;;
    pull_modules)
      check_git
      run_action pull_modules
      shift
    ;;
    push_modules)
      check_git
      run_action push_modules
      shift
    ;;
    sync_modules)
      check_git
      run_action pull_modules
      run_action push_modules
      shift
    ;;
    pull_controlrepo)
      check_git
      run_action pull_controlrepo
      shift
    ;;
    push_controlrepo)
      check_git
      run_action push_controlrepo
      shift
    ;;
    sync_controlrepo)
      check_git
      run_action pull_controlrepo
      run_action push_controlrepo
      shift
    ;;
    make_coffee)
      echo
      echo
      echo "### MAKING COFFEE"
      sleep 2
      echo "Sorry I'm not yet programmed to make coffee. Exiting. Nothing happened."
      shift
    ;;
    do_everything)
      check_gitlab
      check_git
      run_action create_groups
      run_action create_projects
      run_action pull_controlrepo
      run_action push_controlrepo
      run_action pull_modules
      run_action push_modules
      shift
    ;;
    *)
      showhelp
      exit
    ;;
  esac
done

exit $global_exit
