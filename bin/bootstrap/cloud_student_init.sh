#!/bin/bash
yum install -y git
git clone https://github.com/example42/psick /tmp/psick
pushd /tmp/psick
bin/bootstrap/student.sh
popd
rm -fr /tmp/psick
