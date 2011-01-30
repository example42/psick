# Disables iptables (no boot, no run)
class iptables::disable {
    case $operatingsystem {
        centos: { include iptables::redhat::disable }
        redhat: { include iptables::redhat::disable }
        default: { err("No such operatingsystem: $operatingsystem yet defined") }
    }
}

class iptables::redhat::disable inherits iptables::redhat {
    Service ["iptables"] {
        ensure => stopped,
        enable => false,
    }
}
