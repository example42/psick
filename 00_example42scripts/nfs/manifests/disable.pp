# Class: nfs::disable
#
# Stops nfs service and disables it at boot time
#
# Usage:
# include nfs::disable
#
class nfs::disable inherits nfs::server {
    Service["nfs"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
