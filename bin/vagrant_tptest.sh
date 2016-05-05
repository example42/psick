#!/bin/bash

for vm in $(vagrant status | grep running | cut -f 1 -d ' '); do
	echo "### ${vm} ###"
	vagrant ssh $vm -c '/etc/tp/test/* ; exit $?'
done
