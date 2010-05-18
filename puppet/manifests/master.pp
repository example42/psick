class puppet::master inherits puppet {

    # We need rails for storeconfigs
    include rails


    package {
        puppet-server:
        name => $operatingsystem ? {
            default => "puppet-server",
            },
        ensure => present;

        rrdtool-ruby:
        name => $operatingsystem ? {
            default => "rrdtool-ruby",
            },
        ensure => present;
    }

    service { puppetmaster:
        name => $operatingsystem ? {
            default => "puppetmaster",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => [Package[puppet-server],Package[rails]],
    }

    File["puppet.conf"] {
            content => template("puppet/master/puppet.conf.erb"),
            notify  => Service["puppetmaster"],
    }

    File["namespaceauth.conf"] {
            content => template("puppet/master/namespaceauth.conf.erb"),
            notify  => [ Service["puppet"], Service["puppetmaster"] ] ,
    }

    file {
        "tagmail.conf":
            mode => 640, owner => root, group => root,
            require => Package[puppet],
            path => $operatingsystem ?{
                default => "/etc/puppet/tagmail.conf",
            },
            content => template("puppet/master/tagmail.conf.erb"),
    }

}

