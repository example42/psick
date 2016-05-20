#!/bin/bash
action=$1
vm=$2

cd vagrant/environments 
for v in $(ls); do
  cd $v
  [ -d ".vagrant/machines/${vm}" ] && vagrant $action $vm || true
  cd ../
done

