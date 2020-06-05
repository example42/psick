#!/bin/bash
puppet_version=$1
control_repo=$2
yum install -y git
git clone $control_repo /tmp/psick
pushd /tmp/psick
bin/bootstrap/student.sh $puppet_version
popd
rm -fr /tmp/psick
