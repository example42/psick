#!/usr/bin/env bash

puppetdb_server='localhost'
# puppetdb_server='oob-puppetdb-1-prod-01.bnotk.net'
# puppetdb_server=$(puppet config print server)

if [[ "x$1" != "x" ]]; then
  query_params=$1
else
  query_params='inventory[certname]'
fi
curl -k --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey)  --cacert $(puppet config print cacert) -X GET https://$puppetdb_server:8081/pdb/query/v4 --tlsv1 --data-urlencode "query=${query_params}" 

