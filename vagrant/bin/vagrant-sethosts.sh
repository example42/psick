#!/bin/bash
puppet_master_name=$1
puppet_master_ip=$2

echo "### Setting ${puppet_master_ip} puppet ${puppet_master_name} in /etc/hosts"
grep "${puppet_master_ip} puppet ${puppet_master_name}" /etc/hosts || echo "${puppet_master_ip} puppet ${puppet_master_name}" >> /etc/hosts
