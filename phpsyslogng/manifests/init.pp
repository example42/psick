class phpsyslogng::install inherits phpsyslogng {

    $phpsyslogngver="php-syslog-ng-2.9.7"
    $phpsyslogngfile="$phpsyslogngver.tgz"

    exec {
        "phpsyslogng_prerequisites":
            command => $operatingsystem ? {
                default => "yum install -y wget tar gzip",
            },
            onlyif => "test ! -f /usr/src/$phpsyslogngfile",
    }

    exec {
        "phpsyslogng_download":
            command => "cd /usr/src ; wget http://php-syslog-ng.googlecode.com/files/$phpsyslogngfile",
            onlyif => "test ! -f /usr/src/$phpsyslogngfile",
            require => Exec["phpsyslogng_prerequisites"],
    }

    exec {
        "phpsyslogng_extract":
            command => "mkdir /usr/src/phpsyslogng ; cd /usr/src/phpsyslogng ; tar -zxvf $phpsyslogngfile",
            require => Exec["phpsyslogng_download"],
            onlyif => "test ! -d /usr/src/phpsyslogng",
    }

    exec {
        "phpsyslogng_install":
            command => "mkdir /var/www/phpsyslogng ; cp -a /usr/src/phpsyslogng/html/* /var/www/phpsyslogng",
            require => Exec["phpsyslogng_extract"],
    }
}



class phpsyslogng inherits syslog-ng::server::mysql {

    include php
    include mysql

    package {
        "php-syslog-ng":
        name => $operatingsystem ? {
            default => "php-syslog-ng",
            },
            ensure => present,
    }

    file {
        "/var/www/php-syslog-ng/config/config.php":
            owner   => "root",
            group   => "root",
            mode    => "644",
            require => Package["php-syslog-ng"],
            ensure  => present,
    }

    file {
        "/etc/cron.d/phpsyslogng":
            owner   => "root",
            group   => "root",
            mode    => "644",
            require => Package["php-syslog-ng"],
            source  => "puppet://$server/phpsyslogng/phpsyslogng.cron",
    }



}
