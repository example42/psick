class iptables {

	case $operatingsystem {
        	/centos|redhat/: { include iptables::redhat }
        	default: { warning("No such operatingsystem: $operatingsystem yet defined") }
    	}

}
