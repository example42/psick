#!/bin/bash
while [ $# -gt 0 ]; do
  case "$1" in
    --role)
      export FACTER_role=$2
      shift 2
    ;;
    --zone)
      export FACTER_zone=$2
      shift 2
    ;;
    --env)
      export FACTER_env=$2
      shift 2
    ;;
    --datacenter)
      export FACTER_datacenter=$2
      shift 2
    ;;
    --application)
      export FACTER_application=$2
      shift 2
    ;;
    *)
      exit
    ;;
  esac
done
echo "### Setting facts in bash env: role=${role} env=${env} zone=${zone} datacenter=${datacenter} application=${application}"

