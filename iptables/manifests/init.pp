class iptables {

    case $operatingsystem {
        centos: { include iptables::redhat }
        redhat: { include iptables::redhat }
        default: { warning("No such operatingsystem: $operatingsystem yet defined") }
        }

}
