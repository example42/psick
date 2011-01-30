#
# Class: iptables
#
# Manages iptables.
#
# Usage:
# include iptables
#
class iptables {

    # We just include what we need for the Supported OSes

    case $operatingsystem {
        debian: { include iptables::base 
                  include iptables::debian }
        ubuntu: { include iptables::base 
                  include iptables::debian }
        centos: { include iptables::base }
        redhat: { include iptables::base }
        default: { }
    }

}
