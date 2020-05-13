#!/bin/bash
yum install -y git
git clone https://github.com/example42/psick /tmp/psick
pushd /tmp/psick
/tmp/psick/bin/bootstrap/puppet_foss.sh
popd

