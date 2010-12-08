#!/bin/bash
# Very basic, very alpha, Psick IndexPage builder

configfile="/etc/psick/psick.conf"

# Load general configurations
if [ ! -f $configfile ] ; then
    echo "Config file: $configfile not found"
    exit 1
else
    . $configfile
fi

# Main functions
build_index () {
    for host in $(ls -v1 $workdir) ; do
        echo "<h2>$host</h2>" >> $indexfile
        for link in $(ls -v1 $workdir/$host) ; do
            cat $workdir/$host/$link >> $indexfile
        done
    done
}

build_header () {
    cat $confdir/templates/header.html > $indexfile
}

build_footer () {
    cat $confdir/templates/footer.html >> $indexfile
}

build_header
build_index
build_footer
