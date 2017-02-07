#!/usr/bin/env bash

if [[ "x$1" != "x" ]]; then
  query_params="?environment=${1}"
else
  query_params=''
fi
echo "Flushing ${1} environment cache"
curl -i --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey)  --cacert $(puppet config print cacert) -X DELETE https://$(puppet config print server):8140/puppet-admin-api/v1/environment-cache${query_params}
