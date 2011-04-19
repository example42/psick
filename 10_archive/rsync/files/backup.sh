#!/bin/bash
synbak -s ws09 -m rsync
synbak -s cms -m rsync
synbak -s cmstre -m rsync
synbak -s lb02 -m rsync
synbak -s proxy -m rsync
synbak -s xen02 -m rsync
synbak -s mon -m rsync
synbak -s deploy -m rsync
synbak -s syslog -m rsync
synbak -s mon2 -m rsync

