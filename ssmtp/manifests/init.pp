class ssmtp {

    package { ssmtp:
        name => $operatingsystem ? {
            default    => "ssmtp",
            },
        ensure => present,
    }

# ssmtp module is alternative to a sendmail module
# Here sendmail is simply removed

    package { sendmail:
        name => $operatingsystem ? {
            default    => "sendmail",
            },
        ensure => absent,
        require => Package["ssmtp"],
    }


    file {    
             "ssmtp.conf":
            mode => 644, owner => root, group => root,
            require => Package["ssmtp"],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/ssmtp/ssmtp.conf",
            },
    }
    
    file {    
             "revaliases":
            mode => 644, owner => root, group => root,
            require => Package["ssmtp"],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/ssmtp/revaliases",
            },
    }

}
