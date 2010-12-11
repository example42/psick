## EPEL

class repo::epel {
    $extrarepo = epel # Preferred repository (used in nrpe module)
    file {
             "/etc/yum.repos.d/epel.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/epel.repo",
    }
}

