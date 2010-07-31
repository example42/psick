class puppet::master inherits puppet {

    # We need rails for storeconfigs
    include rails

    # On the PuppetMaster is useful the puppet-module-tool
    include puppet::moduletool
    
    case $puppet_nodetool {
        dashboard: { include dashboard }
        foreman: { include foreman }
        default: { }
    }

    package {
        puppet-server:
        name => $operatingsystem ? {
            debian  => "puppetmaster",
            ubuntu  => "puppetmaster",
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
            content => template("puppet/master/puppet.conf.erb"),
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

