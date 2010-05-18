class resolver {

    file {    
             "/etc/resolv.conf":
#            mode => 644, owner => root, group => root,
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/resolv.conf",
            },
            content => template("resolver/resolv.conf"),
    }
}

