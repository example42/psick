#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

PUPPET=$(which puppet)
ERB=$(which erb)
RUBY=$(which ruby)
R10K=$(which r10k)
BASH=$(which bash)
global_exit=0
filter=' grep -v my_filter '

if [ -n ${PUPPET} ]; then
  echo_title "Checking for pesky non printable characters in files."

  grep -I -H -P -n "[\xa0]" --color=yes -r * | $filter |tr '\302\102' 'X'
fi

if [ ! -z ${PUPPET} ]; then
  echo_title "Validating Manifests in site directory"

  for i in $(find site -name '*.pp')
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

echo

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

echo

if [ ! -z ${RUBY} ]; then
  echo_title "Validating YAML files in modules data"
  for i in $(find site/ -name "*.yaml")
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

echo

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


exit $global_exit
