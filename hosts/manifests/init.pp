class hosts {

    file {    
             "hosts":
#            mode => 644, owner => root, group => root,
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/hosts",
            },
    }
}

