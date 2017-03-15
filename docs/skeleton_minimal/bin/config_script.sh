#!/bin/bash
/usr/bin/git --git-dir /etc/puppetlabs/code/environments/$1/.git log --pretty=format:"%h - %an, %ad : %s" -1
