#!/bin/bash
# Managed by Puppet

. /etc/backup_synbak.conf

cd ~

for a in $HOSTSTOBACKUP ; do
        synbak -s $a -m rsync
        if [ $? -eq 0 ] ; then
                echo "$(date) Backup OK on $a" > $DESTDIR/$a.status
        else
                echo "$(date) Backup FAILED on $a" > $DESTDIR/$a.status
        fi
done
