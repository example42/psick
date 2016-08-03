#!/bin/bash
facts_dir=$(puppet config print pluginfactdest)
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
    *)
      exit
    ;;
  esac
done

[ -d $facts_dir ] || mkdir -p $facts_dir
echo "## Setting trusted facts pp_role=${role} , pp_environment=${env} , pp_datacenter=${zone}"
csr_file=$(puppet config print csr_attributes)
mkdir -p $(puppet config print confdir)
echo "---" > $csr_file
echo "  extension_requests:" >> $csr_file
[ -z $role ] || echo "    pp_role: '${role}'" >> $csr_file
[ -z $zone ] || echo "    pp_zone: '${zone}'" >> $csr_file
[ -z $env ]  || echo "    pp_environment: '${env}'" >> $csr_file
