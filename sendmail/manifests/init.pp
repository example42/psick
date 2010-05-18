class sendmail {

    package { 
        sendmail:
        name => $operatingsystem ? {
            default    => "sendmail",
            },
        ensure => present;

        sendmail-cf:
        name => $operatingsystem ? {
            default    => "sendmail-cf",
            },
        ensure => present,
    }

    service { sendmail:
        name => $operatingsystem ? {
            default => "sendmail",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package[sendmail],
    }

    file {    
             "sendmail.mc":
            mode => 644, owner => root, group => root,
            require => Package[sendmail],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/mail/sendmail.mc",
            },
    }

    exec {
        "sendmail_m4compile":
            command => "make -C /etc/mail ; service sendmail restart",
            require => File["sendmail.mc"],
            onlyif  => "m4 /etc/mail/sendmail.mc | diff --ignore-matching-lines=\"^##### built\" - /etc/mail/sendmail.cf ; if ($?=0) ; exit 1 ; fi",
    }
    
}

class sendmail::disable inherits sendmail {
    Service["sendmail"] {
        ensure => "stopped" ,
        enable => "false",
    }
}

class sendmail::absent inherits sendmail {
    Package["sendmail"] {
        ensure => "absent" ,
    }


    Service["sendmail"] {
        ensure => undef ,
        enable => undef ,
    }

    File["sendmail.mc"] {
        ensure => undef ,
    }


}
