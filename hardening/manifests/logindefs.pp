class hardening::logindefs {
    file {
        "login.defs":
            mode => 644, owner => root, group => root,
            ensure => present,
            path   => $operatingsystem ?{
                default => "/etc/login.defs",
            },
            source => "puppet://$servername/hardening/login.defs",
    }

}
