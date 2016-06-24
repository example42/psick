#!/bin/bash
image=$2
role=$1

. config
. env/${image}

echo "## Building on image ${image} role ${role}"
puppet apply -t --basemodulepath "../modules" --hiera_config "hiera.yaml" -e 'include ::docker::profile::rocker_builder'
