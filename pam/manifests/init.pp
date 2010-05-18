class pam {

    package { pam:
        name => $operatingsystem ? {
            default    => "pam",
            },
        ensure => present,
    }

    file {
        "/etc/pam.d/other":
            owner     => root,
            group     => root,
            mode      => 644,
            ensure    => present,
            path      =>  $operatingsystem ? {
                default => "/etc/pam.d/other",
            },
    }

    file {
        "/etc/pam.d/system-auth":
            owner     => root,
            group     => root,
            mode      => 644,
            ensure    => present,
            path      =>  $operatingsystem ? {
                default => "/etc/pam.d/system-auth",
            },
    }

    file {
        "/etc/pam.d/login":
            owner     => root,
            group     => root,
            mode      => 644,
            ensure    => present,
            path      =>  $operatingsystem ? {
                default => "/etc/pam.d/login",
            },
    }

    file {
        "/etc/pam.d/sshd":
            owner     => root,
            group     => root,
            mode      => 644,
            ensure    => present,
            path      =>  $operatingsystem ? {
                default => "/etc/pam.d/sshd",
            },
    }

    file {
        "/etc/pam.d/su":
            owner     => root,
            group     => root,
            mode      => 644,
            ensure    => present,
            path      =>  $operatingsystem ? {
                default => "/etc/pam.d/su",
            },
    }

    file {
        "/etc/pam.d/vsftpd":
            owner     => root,
            group     => root,
            mode      => 644,
            path      =>  $operatingsystem ? {
                default => "/etc/pam.d/vsftpd",
            },
    }

}

class pam::eal4 inherits pam {

    # Pam settings for EAL4+ on Redhat/Centos 5 
    File ["/etc/pam.d/other"] {
            source => "puppet://$servername/pam/eal4/other",
    }

    File ["/etc/pam.d/system-auth"] {
            source => "puppet://$servername/pam/eal4/system-auth",
    }

    File ["/etc/pam.d/login"] {
            source => "puppet://$servername/pam/eal4/login",
    }

    File ["/etc/pam.d/sshd"] {
            source => "puppet://$servername/pam/eal4/sshd",
    }

    File ["/etc/pam.d/su"] {
            source => "puppet://$servername/pam/eal4/su",
    }

#    File ["/etc/pam.d/vfstpd"] {
#            source => "puppet://$servername/pam/eal4/vsftpd",
#    }

}
