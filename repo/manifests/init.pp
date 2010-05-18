class repo {

    package { yum-priorities:
        name => $operatingsystem ? {
            default => "yum-priorities",
            },
        ensure => present,
    }

    case $operatingsystem {
        centos: {
            file {    
                     "/etc/yum.repos.d/CentOS-Base.repo":
                    mode => 644, owner => root, group => root,
                    ensure => present,
                    source => "puppet://$servername/repo/CentOS-Base.repo",
            }
        }

        redhat: {
            file {    
                     "/etc/yum.repos.d/RedHat-Base.repo":
                    mode => 644, owner => root, group => root,
                    ensure => present,
                    source => "puppet://$servername/repo/RedHat-Base.repo",
            }
        }

        fedora: {
            file {    
                     "/etc/yum.repos.d/Fedora.repo":
                    mode => 644, owner => root, group => root,
                    ensure => present,
                    source => "puppet://$servername/repo/Fedora.repo",
            }
        }

        default: {
        }
    }
}

## EPEL

class repo::epel inherits repo {
    $extrarepo = epel # Preferred repository (used in nrpe module)
    file {    
             "/etc/yum.repos.d/epel.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/epel.repo",
    }
}



## RPMFORGE

class repo::rpmforge inherits repo {
    $extrarepo = rpmforge # Preferred repository (used in nrpe module)
    file {    
             "etc/yum.repos.d/rpmforge.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/rpmforge.repo",
    }
}



## LIVNA 

class repo::livna {
    file {    
             "/etc/yum.repos.d/livna.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/livna.repo",
    }
}


## TESTING

class repo::testing  {

    case $operatingsystem {

        centos: {
            file {    
                     "/etc/yum.repos.d/CentOS-Testing.repo":
                    mode => 644, owner => root, group => root,
                    ensure => present,
                    source => "puppet://$servername/repo/CentOS-Testing.repo",
            }
        }

        redhat: {
        }

        fedora: {
        }

        default: {
        }

    }

} # End Class 

