#!/bin/bash
puppet_version=$1
yum install -y git
git clone https://github.com/example42/psick /tmp/psick
pushd /tmp/psick
bin/bootstrap/gitlab.sh $puppet_version
popd
rm -fr /tmp/psick
