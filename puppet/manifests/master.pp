class puppet::master inherits puppet {

    # We need rails for storeconfigs
    include rails

    case $puppet_nodetool {
        dashboard: { include dashboard }
        foreman: { include foreman }
        default: { }
    }

    package {
        puppet-server:
        name => $operatingsystem ? {
            default => "puppet-server",
            },
        ensure => present;

        rrdtool-ruby:
        name => $operatingsystem ? {
            debian => "librrd-ruby",
            ubuntu => "librrd-ruby",
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
            content => $puppet_nodetool ? {
                dashboard => $puppet_externalnodes ? {
                    yes     => template("puppet/dashboard/externalnodes/puppet.conf.erb"),
                    default => template("puppet/dashboard/puppet.conf.erb"),
                },
                foreman   => $puppet_externalnodes ? {
                    yes     => template("puppet/foreman/externalnodes/puppet.conf.erb"),
                    default => template("puppet/foreman/puppet.conf.erb"),
                },
                default   => template("puppet/master/puppet.conf.erb"),
            },
            notify  => [ Service["puppet"], Service["puppetmaster"] ] ,
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

