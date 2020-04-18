#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"
PATH=/opt/puppetlabs/puppet/bin:$PATH
PUPPET=$(which puppet)
ERB=$(which erb)
RUBY=$(which ruby)
R10K=$(which r10k)
BASH=$(which bash)
global_exit=0
filter=' grep -v .js '
check=${1:-all}

check_chars () {
  if [ -n ${PUPPET} ]; then
    echo_title "Checking for pesky non printable characters in files."
  
    grep -I -H -P -n "[\xa0]" --color=yes -r * | $filter |tr '\302\102' 'X'
  fi
}
  
check_manifests () {
  if [ ! -z ${PUPPET} ]; then
    echo_title "Validating Manifests in site directory"
  
    for i in $(find site -name '*.pp' | grep -v plans)
    do
      manifests="$manifests $i"
    done
    echo -ne "$manifests - "
    err=$(${PUPPET} parser validate $manifests 2>&1)
    if [ $? = 0 ]; then
      echo_success "OK"
    else
      echo_failure "ERROR"
      echo $err
      global_exit=1
    fi
  else
    echo_warning "puppet command not found"
  fi
}
  
check_yaml () {
  if [ ! -z ${RUBY} ]; then
    echo_title "Validating YAML files in hieradata/"
    for i in $(find hieradata -name "*.yaml")
    do
      echo -ne "$i - "
      err=$(${RUBY} -e "require 'yaml'; YAML.parse(File.open('$i'))" 2>&1)
      if [ $? = 0 ]; then
        echo_success "OK"
      else
        echo_failure "ERROR"
        echo $err
        global_exit=1
      fi
    done
  else
    echo_warning "ruby not found."
  fi

  if [ ! -z ${RUBY} ]; then
    echo_title "Validating YAML files in modules data"
    files=$(find site/ modules/psick -name "*.yaml")
    while read -r i; do
      echo -ne "$i - "
      err=$(${RUBY} -e "require 'yaml'; YAML.parse(File.open('$i'))" 2>&1)
      if [ $? = 0 ]; then
        echo_success "OK"
      else
        echo_failure "ERROR"
        echo $err
        global_exit=1
      fi
    done <<< "$files"
  else
    echo_warning "ruby not found."
  fi
}

check_erb () {
  if [ ! -z ${ERB} ] && [ ! -z ${RUBY} ]; then
    echo_title "Validation ERB files in site/ directory"
    for i in $(find site -name '*.erb')
    do
      echo -ne "$i - "
      err=$(${ERB} -P -x -T - "${i}" | ${RUBY} -c 2>&1)
      if [ $? = 0 ]; then
        echo_success "OK"
      else
        echo_failure "ERROR"
        echo $err
        global_exit=1
      fi
    done
  else
    echo_warning "erb not found."
  fi
}
    
check_puppetfile () {
  if [ ! -z ${R10K} ]; then
    echo_title "Validating Puppetfile syntax"
    echo -ne "Puppetfile - "
    err=$(${R10K} puppetfile check 2>&1)
    if [ $? = 0 ]; then
      echo_success "OK"
    else
      echo_failure "ERROR"
      echo $err
      global_exit=1
    fi
  else
    echo_warning "r10k not found."
  fi
}
  
check_bash () {
  if [ ! -z ${BASH} ]; then
    echo_title "Validating bash scripts syntax"
    for i in $(find bin/ -name '*.sh')
    do
      echo -ne "$i - "
      err=$(${BASH} -n "${i}" | ${RUBY} -c 2>&1)
      if [ $? = 0 ]; then
        echo_success "OK"
      else
        echo_failure "ERROR"
        echo $err
        global_exit=1
      fi
    done
  else
    echo_warning "bash not found ?!?"
  fi
}

case $check in
  chars) check_chars ;;
  manifests) check_manifests ;;
  yaml) check_yaml ;;
  erb) check_erb ;;
  puppetfile) check_puppetfile ;;
  bash) check_bash ;;
  all)
   check_chars
   check_manifests
   check_yaml
   check_erb
   check_puppetfile
   check_bash
   ;;
  all_but_chars)
   check_manifests
   check_yaml
   check_erb
   check_puppetfile
   check_bash
   ;;
esac 
  
exit $global_exit
