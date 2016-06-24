#!/bin/bash
environment=$1
environmentpath=$(puppet config print environmentpath)
cert=$(puppet config print environmentpath)
key=$(puppet config print )
cacert=$(puppet config print cacert)

cd "${environmentpath}/${environment}"
git pull origin $environment
r10k puppetfile install

curl -i --cert $cert --key $key --cacert $cacert -X DELETE https://localhost:8140/puppet-admin-api/v1/environment-cache?environment=$environment
