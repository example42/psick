#!/bin/bash
# @!parse [text]
# @!parse [text]
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
. "${repo_dir}/bin/config/defaults"

# Customise here the default registry (can be
# defined via the --registry argument). Default
# hub.docker.com is used with example42 puppet-agent
# registry="docker.example.com:5000/puppet"
registry="hub.docker.com:5000/example42"
image="puppet-agent"
version="centos-7"

env=$docker_env
datacenter=$docker_dc
zone=$docker_zone
application=$docker_app
role=$docker_role
runcommand="bash -c "
args="/etc/puppetlabs/code/environments/production/bin/papply.sh --detailed-exitcodes"
custom=""
tags=""
options="--sysctl net.ipv6.conf.all.disable_ipv6=1"
while [ $# -gt 0 ]; do
  CMD=$1
  shift 
  if [ "${1}" != "" ] && [ "${1:0:2}" != "--" ]; then
  	PARAM="$1"
	  shift
  else 
	  PARAM=""
  fi
  case "$CMD" in 
    --tags)
      tags="--tags=${PARAM}"
    ;;
    --registry)
      registry=${PARAM:-$registry}
    ;;
    --image)
      image=${PARAM:-$image}
    ;;
    --version)
      version=${PARAM:-$version}
    ;;
    --shell)
      runcommand=${PARAM:-bash}
      args=""
      options="$options -it"
    ;;
    --role)
      role=$PARAM
    ;;
    --zone)
      zone=$PARAM
    ;;
    --env)
      env=$PARAM
    ;;
    --datacenter)
      datacenter=$PARAM
    ;;
    --application)
      application=$PARAM
    ;;
    --fact)
      custom="$custom -e FACTER_${PARAM}"
    ;;
    *)
	    echo "Invalid paramete $CMD"
	    exit 1
    ;;
  esac
done

if [ ! -z "{$args}" ] && [ ! -z "${tags}" ]; then
  args="${args} ${tags}"
fi
params="-e FACTER_pp_environment=${env} -e FACTER_pp_role=${role} -e FACTER_pp_datacenter=${datacenter} -e FACTER_pp_application=${application} -e FACTER_pp_zone=${zone} $custom"
name="${image}_${version}-${role}-$(date +'%H%M%S')" 
container="${registry}/${image}:${version}" 
PATH=$PATH:/opt/puppetlabs/bin
echo_title "## Running $runcommand on image ${image}:${version} from ${repo_dir}"
echo_subtitle "Defined facts: $params"
docker pull "${registry}${image}:${version}"
docker run $options -v "${repo_dir}:/etc/puppetlabs/code/environments/production"  --name="${name}" $params "${container}" $runcommand "${args}"
exitstatus=$? 
docker rm -f "${name}"

if [ "x${exitstatus}" == "x0" ] || [ "x${exitstatus}" == "x2" ]; then
  exit 0
else
  exit 1
fi
