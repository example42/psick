#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
# repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

# RegExp for whitelist of programs to not uninstall after test
uninstall_whitelist='ssh|vim|lsb|puppet|mcollective|apt|puppet-agent|epel|openjdk-jdk'

show_help () {
  echo
  echo "You must specify the application you want to test and the VM to use:"
  echo "$0 <application> <vm> [check_mode]"
  echo
  echo "To test redis on Ubuntu1404:"
  echo "$0 redis Ubuntu1404"
  echo
  echo "To test redis on all running VMs:"
  echo "$0 redis all"
  echo
  echo "To test all apps on Ubuntu1404:"
  echo "$0 all Ubuntu1404 "
  echo
  echo "To test all apps on Ubuntu1404 and save acceptance tests results:"
  echo "$0 redis Ubuntu1404 acceptance"
  echo
  echo "To test all apps on all running VMs:"
  echo "$0 all all "
}

if [ "x$2" == "x" ]; then
  show_help
  exit 1
fi

app=$1
vm=$2
if [ "x$3" == "x" ]; then
  mode='default'
else
  mode=$3
fi

# puppet_options="$PUPPET_OPTIONS --verbose --report --show_diff --pluginsync --summarize --modulepath '/vagrant/modules_local:/vagrant/modules:/etc/puppet/modules' "
# puppet_command="sudo -i $envs puppet apply"
tp_command="sudo -i tp "

install() {
  i_app=$1
  i_vm=$2  
  echo_title "Installing $i_app on $i_vm"
  vagrant ssh $i_vm -c "$tp_command install $i_app"
}

uninstall() {
  u_app=$1
  u_vm=$2  
  if [[ "$u_app" =~ $uninstall_whitelist ]]; then
    echo_title "Skipping Uninstallation of $u_app on $u_vm"
  else
    echo_title "Uninstalling $u_app on $u_vm"
    vagrant ssh $i_vm -c "$tp_command uninstall $i_app"
  fi
}

default_check() {
  echo 
}
acceptance_check () {
  echo_title "Running acceptance test for $1 on $2"
  rm -f $repo_dir/tests/app/$2/success/$1
  rm -f $repo_dir/tests/app/$2/failure/$1
  rm -f $repo_dir/tests/app/$2/na/$1
  vagrant ssh $2 -c "$tp_command test $1" > /tmp/tp_test_$1_$2
  res=$?
  if [ "x$res" == "x0" ]; then
    result='success'
  elif [ "x$res" == "x99" ]; then
    result='na'
  else
    result='failure'
  fi
  mkdir -p $repo_dir/tests/app/$2/$result
  mv /tmp/tp_test_$1_$2 tests/app/$2/$result/$1
  cat tests/app/$2/$result/$1
  echo_$result "## ${result}! ## Output written to tests/app/$2/${result}/$1"

  uninstall $1 $2
}

if [ "x${app}" == "xall" ]; then
  for a in $(ls -1 $repo_dir/modules/tinydata/data | grep -v default.yaml | grep -v test) ; do
    if [ "x${vm}" == "xall" ]; then
      for v in $(vagrant status | grep running | cut -d ' ' -f1) ; do
        install $a $v
        ${mode}_check $a $v
      done
    else
      install $a $vm
      ${mode}_check $a $vm
    fi
  done
elif [ "x${vm}" == "xall" ]; then
  for v in $(vagrant status | grep running | cut -d ' ' -f1) ; do
    install $app $v
    ${mode}_check $app $v
  done
else
  install $app $vm
  ${mode}_check $app $vm
fi

