#!/bin/bash
which puppet 2>/dev/null
if [ "x$?" == "x0" ]; then 
  facts_dir=$(puppet config print pluginfactdest)
  confdir=$(puppet config print confdir)
  csr_file=$(puppet config print csr_attributes)
else
  facts_dir=/opt/puppetlabs/puppet/cache/facts.d
  confdir=/etc/puppetlabs/puppet
  csr_file=/etc/puppetlabs/puppet/csr_attributes.yaml
fi

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
if [ ! -f $csr_file ]; then
  echo "### Setting trusted facts pp_role=${role} pp_environment=${env} pp_zone=${zone} pp_datacenter=${datacenter} pp_application=${application}"
  mkdir -p $confdir
  echo "---" > $csr_file
  echo "  extension_requests:" >> $csr_file
  [ -z $role ] || echo "    pp_role: '${role}'" >> $csr_file
  [ -z $zone ] || echo "    pp_zone: '${zone}'" >> $csr_file
  [ -z $env ]  || echo "    pp_environment: '${env}'" >> $csr_file
  [ -z $datacenter ]  || echo "    pp_datacenter: '${datacenter}'" >> $csr_file
  [ -z $application ]  || echo "    pp_application: '${application}'" >> $csr_file
fi

