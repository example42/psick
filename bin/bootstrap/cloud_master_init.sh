#!/bin/bash
echo "10.0.1.1 puppet\n10.0.1.2 gitlab\n" >> /etc/hosts
puppet_version=$1
control_repo=$2
yum install -y git
git clone $control_repo /tmp/psick
pushd /tmp/psick
bin/bootstrap/puppet_foss.sh $puppet_version $control_repo
popd

