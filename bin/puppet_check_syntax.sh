#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

PUPPET=$(which puppet)
ERB=$(which erb)
RUBY=$(which ruby)
global_exit=0
filter='grep -v www/pcdb/js'

if [ -n ${PUPPET} ]; then
  echo_title "Checking for pesky non printable characters in files."

  grep -I -H -P -n "[\xa0]" --color=yes -r * | $filter |tr '\302\102' 'X'
fi

if [ ! -z ${PUPPET} ]; then
  echo_title "Validating Manifests in site directory"

  for i in $(find site -name '*.pp')
  do
    echo -ne "$i - "
    err=$(${PUPPET} parser validate $i 2>&1)
    if [ $? = 0 ]; then
      echo_success "OK"
    else
      echo_failure "ERROR"
      echo $err
      global_exit=1
    fi
  done
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

if [ ! -z ${ERB} ] && [ ! -z ${RUBY} ]; then
  echo_title "Validation ERB files in site/ directory"
  for i in $(find site -name '*.erb')
  do
    echo -ne "$i - "
    err=$(${ERB} -x -T - "${i}" | ${RUBY} -c 2>&1)
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

exit $global_exit
