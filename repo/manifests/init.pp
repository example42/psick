# Simple class for yum.repos.d management for Centos/RedHat
# 
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


