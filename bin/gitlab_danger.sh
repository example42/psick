#!/bin/bash
PATH=/opt/puppetlabs/puppet/bin:$PATH
echo "Run Danger"
cli_vars=$(cat /etc/gitlab-cli.conf)
for v in $cli_vars; do
  export $v
done
danger --verbose
