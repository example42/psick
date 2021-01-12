#!/bin/bash
# Script to migrate Puppet agent for legacy setups:
# - old 3.8 Puppet Enterprise (PE) agents
# - Open Source Puppet (OSP) agents

# Currently works only on Redhat systems

# Variables to edit

# Puppet master
server='puppet'

# On what systems is the client to migrate ('pe' or 'osp')
migrate_from='pe'

# Where to backup Puppet files
backup_dir=/tmp/puppet_migration

# List of concat files to exclude from diff view (changes here are known and we don't want to see them)
CONCAT_FILES=( $(ls /usr/local/sbin/fooacl /var/lib/pgsql/data/pg_hba.conf /var/opt/lib/pe-puppet/.ssh/config 2>/dev/null | tr "\012" " " ) )

# List of files to exclude from diff view (changes here are known and we don't want to see them)
EXPECTED_FILES=( /usr/local/bin/puppet /usr/local/sbin/agent_suspend.sh /usr/local/sbin/pagent /etc/puppetlabs/puppet/puppet.conf )
  
# Source of the list of managed files, packages and dirs to remove change with pe or osp
if ($migrate_from = 'pe'); then
  filelist=$(cat /var/opt/lib/pe-puppet/state/resources.txt | grep "^file" | sed -e 's/^file\[//g' | sed -e 's/\]$//g' | grep -v concat | grep -v "/var/log" )
  packages_to_remove='pe-* puppet-enterprise-installer'
  dirs_to_remove='/etc/puppetlabs/puppet /etc/puppetlabs/mcollective'
else
  filelist=$(cat /opt/puppetlabs/puppet/cache/state/resources.txt | grep "^file" | sed -e 's/^file\[//g' | sed -e 's/\]$//g' | grep -v concat | grep -v "/var/log" )
  packages_to_remove='puppet-agent'
  dirs_to_remove='/etc/puppetlabs/puppet /etc/puppetlabs/mcollective'
fi


# NO EDITS below
start_time=$(date +%Y%m%d-%H%m%S)
export PATH=$PATH:/opt/puppetlabs/bin:/opt/puppet/bin

## First argument is the action to perform
if [[ "x${1}" != "x" ]]; then
  action=$1
  shift
else
  action='none'
fi

### Cosmetics
if tty -s
then
  SETCOLOR_SUCCESS=$(tput setaf 2)
  SETCOLOR_FAILURE=$(tput setaf 1)
  SETCOLOR_WARNING=$(tput setaf 3)
  SETCOLOR_ASK=$(tput setaf 13)
  SETCOLOR_NORMAL=$(tput sgr0)
  SETCOLOR_TITLE=$(tput setaf 6)
  SETCOLOR_SUBTITLE=$(tput setaf 14)
  SETCOLOR_BOLD=$(tput setaf 15)
else
  SETCOLOR_SUCCESS="-"
  SETCOLOR_FAILURE="-"
  SETCOLOR_WARNING="-"
  SETCOLOR_ASK="-"
  SETCOLOR_NORMAL="-"
  SETCOLOR_TITLE="-"
  SETCOLOR_SUBTITLE="-"
  SETCOLOR_BOLD="-"
fi
echo_title () {
  echo
  echo "${SETCOLOR_BOLD}###${SETCOLOR_NORMAL} ${SETCOLOR_TITLE}${1}${SETCOLOR_NORMAL} ${SETCOLOR_BOLD}###${SETCOLOR_NORMAL}"
}
echo_warning() {
  echo "${SETCOLOR_WARNING}${1}${SETCOLOR_NORMAL}"
  return 1
}
echo_failure() {
  echo "${SETCOLOR_FAILURE}${1}${SETCOLOR_NORMAL}"
  return 1
}
echo_success() {
  echo "${SETCOLOR_SUCCESS}${1}${SETCOLOR_NORMAL}"
  return 1
}
check_result() {
  if [[ "$1" != "0" ]] && [[ "$force" == "false" ]]; then
    echo_failure "Command failed! Existing"
    exit 1
  fi
}

check_server() {
  echo "We are going to use Puppet server: ${server}"
  echo
  nc -w 5 $server 8140 </dev/null >&/dev/null
  if [ "x$?" == "x0" ]; then
    echo_success "Good, we can reach ${server}. Continuing"
  else
    echo_failure "Bad News. We cannnot reach server: ${server}. Aborting"
    exit 1
  fi
}

usage() {
cat <<HELP
This script handles the migration of a node using OLD agents based on OSP old PE (3.8) installation
to a new server, based on current PE.
It is expected to be run as roon on RedHat or derivative systems.

The node's Puppet certificate is going to be recreated, rollback option is available.

Backups of old configs and files are stored under $backup_dir

Usage: ${0} <action>

Available actions:

  run_old_puppet        Run puppet agent (on OLD setup, unless already migrated)
  remove_old_puppet     Remove OLD puppet agent packages and configurations
  backup_managed_files  Do a backup under $backup_dir of files managed by Puppet
  install_new_puppet    Install NEW puppet agent from new PE server
  run_new_puppet_concat Run puppet on NEW server, apply only concat resources
  show_diff_concat      Show diffs in concat resources (changes from OLD to NEW)
  run_new_puppet        Run puppet agent on NEW server
  show_diff             Show diffs in all files managed by Puppet (changes from OLD to NEW)
  show_diff_resources   Show diffs in resources.txt file (changes from OLD to NEW)

  all      Do all the above steps in sequence (RECOMMENDED action)
  express  Perform the whole migration unattended, without asking questions (do only if confident)
  rollback Reinstall OLD Puppet and rollback to previous configs (do only if strictly necessary)
  rollforward Reinstall NEW Puppet after a rollback to OLD. Previous NEW configs and new agent are reinstalled)

Example: $0 all

HELP
}

intro() {
  echo_title "Puppet migration Introduction"
  echo "This script can be used to migrate the local node from its existing  old Puppet infrastructure to"
  echo "the a new one based on Puppet Enteprise. Several changes in Puppet related files are expected in the first Puppet run"
  echo "but there should no be changes in other configuration files. You will be provided the option to run Puppet"
  echo "in noop mode and to check changes with diff in the Puppet managed files."
  echo
  echo_warning "You can abort this script at any time by typing CTRL+C"
  echo "In case of interruption, run the single actions that you missed."
}

run_old_puppet() {
  echo_title "Preventive Puppet Run"
  echo "First we need to run puppet on the existing setup to check that everything is fine."
  echo
  echo "Going to run puppet agent -t without changes to Puppet installation. Press: "
  echo "- [y] or [ENTER] to proceed (DEFAULT)"
  echo "- Any other key to skip to the next step"
  read -p "Your choice: " answer
  answer=${answer:-y}
  if [ $answer == 'y' ]; then
  [ -d "${backup_dir}" ] || mkdir -p "${backup_dir}"
  echo_warning "The output of this puppet run is also saved to ${backup_dir}/${start_time}-puppet-agent-pre.log"
  puppet agent -t --detailed-exitcodes | tee "${backup_dir}/${start_time}-puppet-agent-pre.log"
    if [[ "x${PIPESTATUS[0]}" == "x0" ]] || [[ "x${PIPESTATUS[0]}" == "x2" ]] ; then
      echo_success "Puppet run seems fine, we can proceed :-)"
    else
      echo_failure "We got some errors in the current Puppet run!"
      echo "You should consider the opportunity to fix these errors before proceeding."
      echo "Shall we continue in any case?"
      echo "The above errors are likely to appear also on the new run with new server."
      echo "- [y] to proceed"
      echo "- [ENTER] or any other key to abort (DEFAULT)"
      read -p "Your choice: " answer
      answer=${answer:-n}
      if [ $answer != 'y' ]; then
        echo_failure "Interrupting migration."
        echo "No changes were done. Please fix the existing Puppet run and try again."
        exit 1
      fi
    fi
  fi
}


backup_files() {
  echo_title "Making a copy of all Puppet managed files under ${backup_dir}/files"
  for file in $filelist; do
    if [ -f $file ]; then
      dirname=$(dirname $file)
      basename=$(basename $file)
      mkdir -p "${backup_dir}/files${dirname}"
      cp $file "${backup_dir}/files${dirname}/${basename}"
    fi
  done
}

remove_old_puppet_packages() {
  echo_title "Removing existing Puppet packages (yum remove $packages_to_remove) "
  yum remove $packages_to_remove -y -q
  if ($dirs_to_remove != '/'); then
    rm -rf $dirs_to_remove
  fi
}

backup_old_puppet_configs() {
  echo_title "Moving old Puppet certs and configs under ${backup_dir}/backup_old"
  mkdir -p "${backup_dir}/backup_old"
  [ -d /etc/puppetlabs/puppet ] && cp -a  /etc/puppetlabs/puppet "${backup_dir}/backup_old"
  [ -d /etc/puppetlabs/mcollective ] && cp -a /etc/puppetlabs/mcollective "${backup_dir}/backup_old"
}

backup_new_puppet_configs() {
  echo_title "Moving new Puppet certs (post-migration) and configs under ${backup_dir}/backup_new"
  mkdir -p "${backup_dir}/backup_new"
  [ -d /etc/puppetlabs/puppet ] && cp -a  /etc/puppetlabs/puppet "${backup_dir}/backup_new"
  [ -d /etc/puppetlabs/pxp-agent ] && cp -a /etc/puppetlabs/pxp-agent "${backup_dir}/backup_new"
}

copy_old_puppet_resources_txt() {
  [ -d "${backup_dir}" ] || mkdir -p "${backup_dir}"
  echo_title "Copying /opt/puppetlabs/puppet/cache/state/resources.txt to ${backup_dir}/resources.txt-old"
  [ -f /opt/puppetlabs/puppet/cache/state/resources.txt ] && cp /opt/puppetlabs/puppet/cache/state/resources.txt "${backup_dir}/resources.txt-old"

  echo_title "Creating a clean and sorted ${backup_dir}/resources.txt-old-clean"
  cat "${backup_dir}/resources.txt-old" | sort | tr '[:upper:]' '[:lower:]' | grep -v "ssh_authorized_key" > "${backup_dir}/resources.txt-old-sorted"
  cat > "${backup_dir}/resources.txt-old-known" << OLD_KNOWN
package[puppet-agent]
OLD_KNOWN

  comm -2 -3 "${backup_dir}/resources.txt-old-sorted" "${backup_dir}/resources.txt-old-known" > "${backup_dir}/resources.txt-old-clean"
}

copy_new_puppet_resources_txt() {
  echo_title "Copying /opt/puppetlabs/puppet/cache/state/resources.txt to ${backup_dir}/resources.txt-new"
  [ -f /opt/puppetlabs/puppet/cache/state/resources.txt ] && cp /opt/puppetlabs/puppet/cache/state/resources.txt "${backup_dir}/resources.txt-new"

  echo_title "Creating a clean and sorted ${backup_dir}/resources.txt-new-clean"
  cat "${backup_dir}/resources.txt-new" | sort | tr '[:upper:]' '[:lower:]' | grep -v "ssh_authorized_key" > "${backup_dir}/resources.txt-new-sorted"
  cat > "${backup_dir}/resources.txt-new-known" << NEW_KNOWN
exec[pe_patch::exec::fact]
exec[pe_patch::exec::fact_upload]
file[/etc/puppetlabs/puppet/puppet-agent.conf]
file[/etc/puppetlabs/pxp-agent/pxp-agent.conf]
file[/opt/puppetlabs/bin/puppet-enterprise-uninstaller]
file[/opt/puppetlabs/puppet/cache/state/package_inventory_enabled]
file[/usr/local]
file[/usr/local/bin]
file[/usr/local/bin/facter]
file[/usr/local/bin/hiera]
file[/usr/local/bin/os_patching_fact_generation.sh]
file[/usr/local/bin/pe_patch_fact_generation.sh]
file[/usr/local/bin/puppet]
file[/var/cache/os_patching]
file[/var/cache/pe_patch]
file[/var/cache/pe_patch/blackout_windows]
file[/var/cache/pe_patch/block_patching_on_warnings]
file[/var/cache/pe_patch/patch_group]
file[/var/cache/pe_patch/pre_patching_command]
file[/var/cache/pe_patch/reboot_override]
file[/var/puppet/var/state]
pe_ini_setting[agent conf file server_list]
service[pxp-agent]
NEW_KNOWN

  comm -2 -3 "${backup_dir}/resources.txt-new-sorted" "${backup_dir}/resources.txt-new-known" > "${backup_dir}/resources.txt-new-clean"
}

remove_old_puppet() {
  runmode=${1:-normal}
  echo_title "Removal of existing Puppet installation"

  if [ $runmode == 'unattended' ]; then
    backup_old_puppet_configs
    remove_old_puppet_packages
  else
    echo "We are going to backup Puppet configuration files and uninstall old Puppet version"
    echo "Press:"
    echo "- [y] or [ENTER] to proceed (DEFAULT)"
    echo "- [s] to skip this step"
    echo "- Any other key to abort"
    read -p "Your choice: " answer
    answer=${answer:-y}
    if [ $answer == 'y' ]; then
      backup_old_puppet_configs
      remove_old_puppet_packages
    elif [ $answer == 's' ]; then
      echo_warning "Skipping old Puppet Agent removal"
    else
      echo_failure "Migration aborted. Nothing done"
      exit 1
    fi
  fi
}

reinstall_old_puppet() {
  if ($migrate_from == 'pe'); then
    reinstall_old_puppet_pe
  fi
  if ($migrate_from == 'osp'); then
    reinstall_old_puppet_osp
  fi

}

reinstall_old_puppet_osp() {
  /usr/bin/yum -y install puppet
}


reinstall_old_puppet_pe() {
  /usr/bin/yum -y -d2 install puppet-enterprise-installer
  cd `rpm -ql puppet-enterprise-installer | head -1`
  cat > /tmp/answers.$$ << FINITA
q_fail_on_unsuccessful_master_lookup=n
q_install=y
q_puppet_cloud_install=n
q_puppet_enterpriseconsole_install=n
q_puppet_symlinks_install=y
q_puppetagent_certname=$(uname -n)
q_puppetagent_install=y
q_puppetagent_server=puppet
q_puppetca_install=n
q_puppetdb_install=n
q_run_updtvpkg=n
q_puppetmaster_install=n
q_vendor_packages_install=y
q_verify_packages=n
q_puppet_agent_first_run=n
FINITA

  ./puppet-enterprise-installer -a /tmp/answers.$$ -l /tmp/pe-installer.log
}

rollback_old_puppet_configs() {
  echo_title "Copying back old configs"
  rsync -av $backup_dir/backup_old/puppet /etc/puppetlabs/
  rsync -av $backup_dir/backup_old/mcollective /etc/puppetlabs/

  echo_warning "Old Puppet reinstalled. Please do check if everything to back to normal"
}
rollback_new_puppet_configs() {
  echo_title "Copying back new configs"
  mkdir -p /etc/puppetlabs
  rsync -av $backup_dir/backup_new/puppet /etc/puppetlabs/
  rsync -av $backup_dir/backup_new/pxp-agent /etc/puppetlabs/

  echo_warning "New Puppet configs reinstalled."
}

remove_new_puppet() {
  echo_title "Removing new Puppet installation :-I"
  backup_new_puppet_configs
  yum remove -y -q puppet-agent
}

rollback() {
  echo_title "Rolling back OLD Puppet installation"
  echo "We are going to remove NEW puppet-agent package and reinstall the OLD packages"
  echo "Press:"
  echo "- [y] or [ENTER] to proceed (DEFAULT)"
  echo "- Any other key to abort"
  read -p "Your choice: " answer
  answer=${answer:-y}
  if [ $answer == 'y' ]; then
    remove_new_puppet
    reinstall_old_puppet
    rollback_old_puppet_configs
  fi
}

install_new_puppet_script() {
  [ -d /etc/puppetlabs/facter/facts.d ] ||  mkdir -p /etc/puppetlabs/facter/facts.d

  echo_title "Installing Puppet-agent from PE server"
  curl -k https://$server:8140/packages/current/install.bash | sudo bash -s -- --puppet-service-ensure stopped
  hash puppet
}

install_new_puppet() {
  runmode=${1:-normal}
  puppet --version 2>/dev/null | grep "^[6|7|8]"
  if [ "x$?" == "x0" ]; then
    echo_title "Puppet version 6 or higher present. Skipping installation."
    echo "If you want to [re]install a NEW puppet agent, run the following command:"
    echo "curl -k https://$server:8140/packages/current/install.bash | sudo bash"
  else
    if [ $runmode == 'unattended' ]; then
      install_new_puppet_script  
    else
      echo_title "Going to install the new puppet-agent package."
      echo "The new Puppet Enterprise server for this region is: ${server}."
      echo "Press:"
      echo "- [y] or [ENTER] to proceed (DEFAULT)"
      echo "- [s] to skip this step (you need to problems in installing new puppet-agent if old puppet packages are in place)"
      echo "- Any other key to abort"
      read -p "Your choice: " answer
      answer=${answer:-y}
      if [ $answer == 'y' ]; then
        install_new_puppet_script  
      elif [ $answer == 's' ]; then
        echo_warning "Skipping new Puppet Agent installation"
      else
        echo_failure "Migration aborted. Nothing done"
        exit 1
      fi
    fi
  fi
}

backup_concats() {
  echo_title "Copying files managed via concat in ${backup_dir}/concats"
  for file in "${CONCAT_FILES[@]}"; do
    if [ -f $file ]; then
      dirname=$(dirname $file)
      basename=$(basename $file)
      mkdir -p "${backup_dir}/concats/${dirname}"
      cp $file "${backup_dir}/concats/${dirname}/${basename}"
    fi
  done
}

run_new_puppet_concat() {
  echo_title "Going to run puppet only for concat resources"

  echo "Do you want to proceed with a Puppet run only on concat resources? Press:"
  echo "- [y] or [ENTER] for a normal puppet run (DEFAULT)"
  echo "- [n] for a noop puppet run"
  echo "- Any other key to skip "
  read -p "Your choice: " answer
  answer=${answer:-y}
  if [ $answer == 'y' ]; then
    [ -d "${backup_dir}" ] || mkdir -p "${backup_dir}"
    echo_title "Running puppet agent -t --tags=concat --server $server --waitforcert 10"
    echo_warning "Be sure to have autosign configured on the server or sign manually this client certificate"
    echo_warning "The output of this puppet run is also saved to ${backup_dir}/${start_time}-puppet-agent-concat.log"
    puppet agent -t --tags concat --server $server --waitforcert 10  | tee "${backup_dir}/${start_time}-puppet-agent-concat.log"
  elif [ $answer == 'n' ]; then
    [ -d "${backup_dir}" ] || mkdir -p "${backup_dir}"
    echo_title "Running puppet agent -t --tags=concat --noop --server $server --waitforcert 10"
    echo_warning "Be sure to have autosign configured on the server or sign manually this client certificate"
    echo_warning "The output of this puppet run is also saved to ${backup_dir}/${start_time}-puppet-agent-concat-noop.log"
    puppet agent -t --tags concat --noop --server $server --waitforcert 10  | tee "${backup_dir}/${start_time}-puppet-agent-concat-noop.log"
  else
    echo_warning "Skipping puppet run, nothing done"
  fi
}

show_diff_concat() {
  echo_title "Showing diffs in files managed via concat"
  echo "Please check if you see unexpected changes"
  for file in "${CONCAT_FILES[@]}"; do
    if [ -f $file ]; then
      dirname=$(dirname $file)
      basename=$(basename $file)
      mkdir -p "${backup_dir}/concats/${dirname}"
      diff "${backup_dir}/concats${dirname}/${basename}" $file > /dev/null
      if [[ "x$?" != "x0" ]]; then
        echo
        echo_warning $file
        diff "${backup_dir}/concats${dirname}/${basename}" $file
      fi
    fi
  done
}

run_puppet_agent() {
  [ -d "${backup_dir}" ] || mkdir -p "${backup_dir}"
  echo_title "Running puppet agent -t --server $server --waitforcert 10"
  echo_warning "Be sure to have autosign configured on the server or sign manually this client certificate"
  echo_warning "The output of this puppet run is also saved to ${backup_dir}/${start_time}-puppet-agent.log"
  puppet agent -t --server $server --waitforcert 10  | tee "${backup_dir}/${start_time}-puppet-agent.log"
}

run_new_puppet() {
  echo "Do you want to proceed with a full Puppet run? Press:"
  echo "- [y] or [ENTER] for a normal puppet run (DEFAULT)"
  echo "- [n] for a noop puppet run"
  echo "- Any other key to skip "
  read -p "Your choice: " answer
  answer=${answer:-y}
  if [ $answer == 'y' ]; then
    [ -d "${backup_dir}" ] || mkdir -p "${backup_dir}"
    echo_title "Running puppet agent -t --server $server"
    echo_warning "The output of this puppet run is also saved to ${backup_dir}/${start_time}-puppet-agent.log"
    puppet agent -t --server $server | tee "${backup_dir}/${start_time}-puppet-agent.log"
    puppet resource service puppet ensure=running enable=true
  elif [ $answer == 'n' ]; then
    [ -d "${backup_dir}" ] || mkdir -p "${backup_dir}"
    echo_title "Running puppet agent -t --noop --server $server"
    echo_warning "The output of this puppet run is also saved to ${backup_dir}/${start_time}-puppet-agent-noop.log"
    puppet agent -t --noop --server $server | tee "${backup_dir}/${start_time}-puppet-agent-noop.log"

    echo "Puppet run was in noop mode, if changes look ok for you, make a real run with 'puppet agent -t --server $server'."
    echo
    echo "Always remember to check Puppet Enterprise web console for realtime status of your infrastructure"
    echo "Access it with your markit credentials at https://${server}"

  else
    echo_warning "Skipping puppet run."
  fi
}

show_diff() {
  echo_title "Showing if there are differences in Puppet managed files. Comparing actual location with backups under ${backup_dir}/files"
  echo "You can ignore the diffs on log files"
  for file in $filelist; do
    if [ -f $file ] && [[ ! " ${EXPECTED_FILES[@]} " =~ " ${file} " ]]; then
      dirname=$(dirname $file)
      basename=$(basename $file)
      diff "${backup_dir}/files${dirname}/${basename}" $file > /dev/null
      if [[ "x$?" != "x0" ]]; then
        echo
        echo_warning $file
        diff "${backup_dir}/files${dirname}/${basename}" $file
      fi
    fi
  done
}

show_diff_resources_txt() {
  echo_title "Showing if there are differences in Puppet managed resources."
  echo "This should be empty or contain known diffs"
  diff "${backup_dir}/resources.txt-old-clean" "${backup_dir}/resources.txt-new-clean"

  echo_title "Showing total counts of resources with changing titles"
  echo "Exec resources on OLD: $(grep '^exec' $backup_dir/resources.txt-old-clean | wc -l)"
  echo "Exec resources on NEW: $(grep '^exec' $backup_dir/resources.txt-new-clean | wc -l)"
  echo
  echo "Cron resources on OLD $(grep '^cron' $backup_dir/resources.txt-old-clean | wc -l)"
  echo "Cron resources on NEW $(grep '^cron' $backup_dir/resources.txt-new-clean | wc -l)"
}

case $action in
  run_old_puppet)
    run_old_puppet
  ;;
  remove_old_puppet)
    remove_old_puppet
  ;;
  install_new_puppet)
    check_server
    install_new_puppet
  ;;
  backup_managed_files)
    backup_concats
    backup_files
  ;;
  run_new_puppet_concat)
    check_server
    run_new_puppet_concat
  ;;
  show_diff_concat)
    show_diff_concat
  ;;
  run_new_puppet)
    check_server
    run_new_puppet
  ;;
  show_diff)
    show_diff
  ;;
  show_diff_resources)
    show_diff_resources_txt
  ;;
  rollback)
    rollback
  ;;
  rollforward)
    run_old_puppet
    copy_old_puppet_resources_txt
    backup_concats
    backup_files
    remove_old_puppet
    rollback_new_puppet_configs
    install_new_puppet
    run_new_puppet
    copy_new_puppet_resources_txt
    show_diff
    show_diff_resources_txt
    run_puppet_agent
  ;;
  all)
    intro
    check_server
    run_old_puppet
    copy_old_puppet_resources_txt
    backup_concats
    backup_files
    remove_old_puppet
    install_new_puppet
    run_new_puppet_concat
    show_diff_concat
    run_new_puppet
    copy_new_puppet_resources_txt
    show_diff
    show_diff_resources_txt
    run_puppet_agent
  ;;
  express)
    check_server
    copy_old_puppet_resources_txt
    backup_concats
    backup_files
    remove_old_puppet unattended
    install_new_puppet unattended
    run_puppet_agent
    copy_new_puppet_resources_txt
    show_diff_concat
    show_diff
    show_diff_resources_txt
    run_puppet_agent

  ;;
  *)
    usage
  ;;
esac
