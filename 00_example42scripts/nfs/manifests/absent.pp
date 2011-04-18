# Class: nfs::absent
#
# Removes nfs package
#
# Usage:
# include nfs::absent
#
class nfs::absent inherits nfs {
    Package["nfs"] {
        ensure => "absent" ,
    }
}
