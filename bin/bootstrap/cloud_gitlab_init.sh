#!/bin/bash
yum install -y git
git clone https://github.com/example42/psick /tmp/psick
pushd /tmp/psick
bin/bootstrap/gitlab.sh
popd
rm -fr /tmp/psick
