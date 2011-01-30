class iptables::redhat {

    service { iptables:
        name => $operatingsystem ? {
            default => "iptables",
            },
        ensure => running,
        enable => true,
        hasrestart => false,
        restart => "iptables-restore < /etc/sysconfig/iptables",
        hasstatus => true,
        # Uncomment to automate iptables restart on config change (Careful!!)
        # subscribe File["iptables"],
    }

    file {    
             "iptables":
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/sysconfig/iptables",
            },
    }

}
