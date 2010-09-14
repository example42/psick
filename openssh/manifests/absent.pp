# Class: openssh::absent
#
# Removes openssh package
#
# Usage:
# include openssh::absent
#
class openssh::absent inherits openssh {
    Package["openssh"] {
        ensure => "absent" ,
    }
}
