# Class: openvpn::backup::absent
#
# Remove openvpn backup elements
#
class openvpn::backup::absent {

    include openvpn::params

    backup { "openvpn_data": 
        frequency => "${openvpn::params::backup_frequency}",
        path      => "${openvpn::params::datadir}",
        enabled   => "false",
        target    => "${openvpn::params::backup_target_real}",
    }
    
    backup { "openvpn_logs": 
        frequency => "${openvpn::params::backup_frequency}",
        path      => "${openvpn::params::logdir}",
        enabled   => "false",
        target    => "${openvpn::params::backup_target_real}",
    }

}
