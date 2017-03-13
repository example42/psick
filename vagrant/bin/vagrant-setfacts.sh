#!/bin/bash
facts_dir=/etc/puppetlabs/facter/facts.d
# facts_dir=$(puppet config print pluginfactdest)
[ -d $facts_dir ] || mkdir -p $facts_dir
while [ $# -gt 0 ]; do
  case "$1" in
    --role)
      role=$2
      shift 2
    ;;
    --zone)
      zone=$2
      shift 2
    ;;
    --env)
      env=$2
      shift 2
    ;;
    --datacenter)
      datacenter=$2
      shift 2
    ;;
    --application)
      application=$2
      shift 2
    ;;
    *)
      exit
    ;;
  esac
done

[ -d $facts_dir ] || mkdir -p $facts_dir
echo "### Setting external facts role=${role} env=${env} zone=${zone} datacenter=${datacenter} application=${application}"
[ -z $role ] || echo "role=${role}" > "${facts_dir}/role.txt"
[ -z $zone ] || echo "zone=${zone}" > "${facts_dir}/zone.txt"
[ -z $env ]  || echo "env=${env}" > "${facts_dir}/env.txt"
[ -z $application ]  || echo "application=${application}" > "${facts_dir}/application.txt"
[ -z $datacenter ]  || echo "datacenter=${datacenter}" > "${facts_dir}/datacenter.txt"

