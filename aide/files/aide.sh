#!/bin/sh
if [ -f /var/lib/aide/aide.db.gz ]; then 
	/usr/sbin/aide --check
else
	/usr/sbin/aide --init
	cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
	
	TMPAIDE="/tmp/aide"
	date > $TMPAIDE
	hostname >> $TMPAIDE
	md5sum /etc/aide.conf >> $TMPAIDE
	md5sum /var/lib/aide/aide.db.new.gz >> $TMPAIDE
	md5sum /usr/sbin/aide >> $TMPAIDE

	if [ -x /usr/sbin/ssmtp ]; then
		cat $TMPAIDE | ssmtp  root
	else 
		cat $TMPAIDE | mail -s "AIDE MD5SUMS: `hostname` " root
	fi

	rm -f $TMPAIDE
fi
