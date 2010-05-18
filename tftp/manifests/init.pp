class tftp {

    package { 
        "tftp-server":
        name => $operatingsystem ? {
            default => "tftp-server",
            },
        ensure => present,
    }

    file {
        "/etc/xinetd.d/tftp":
            owner   => "root",
            group   => "root",
            mode    => "644",
            source  => "puppet://$server/tftp/tftp.xinetd",
    }

}
