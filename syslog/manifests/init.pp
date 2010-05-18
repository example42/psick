import "*.pp"

class syslog {
    case $operatingsystem {
        suse:    { include syslog-ng }
        centos:  { include syslog::base }
        redhat:  { include syslog::base }
        ubuntu:  { include syslog::base }
        debian:  { include syslog::base }
        freebsd: { }
    }
}
