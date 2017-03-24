#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
. "${repo_dir}/bin/config/defaults"

registry="myregistry.domain.name/puppet/"
image="centos-7"
version="latest"

env=$docker_env
datacenter=$docker_dc
zone=$docker_zone
application=$docker_app
role=$docker_role
runcommand="bash -c /etc/puppetlabs/code/environments/production/bin/papply.sh --detailed-exitcodes"
custom=""
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
      runcommand="${runcommand} --tags ${PARAM}"
    ;;
    --image)
      image=${PARAM:-$image}
    ;;
    --version)
      version=${PARAM:-$version}
    ;;
    --shell)
      runcommand=${PARAM:-bash}
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

params="-e FACTER_pp_environment=${env} -e FACTER_pp_role=${role} -e FACTER_pp_datacenter=${datacenter} -e FACTER_pp_application=${application} -e FACTER_pp_zone=${zone} $custom"
name="${image}_${version}-${role}-$(date +'%H%M%S')" 
container="${registry}${image}:${version}" 
PATH=$PATH:/opt/puppetlabs/bin
echo_title "## Running $runcommand on image ${image}:${version} from ${repo_dir}"
echo_subtitle "Defined facts: $params"
docker pull "${registry}${image}:${version}"
docker run $options -v "${repo_dir}:/etc/puppetlabs/code/environments/production"  --name="${name}" $params "${container}" $runcommand
exitstatus=$? 
docker rm -f "${name}"

if [ "x${exitstatus}" == "x0" ] || [ "x${exitstatus}" == "x2" ]; then
  exit 0
else
  exit 1
fi
