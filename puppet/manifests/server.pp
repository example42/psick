#
# Class: puppet::server
#
# Manages puppet server
# Include it to install and run puppetmaster 
# It defines package, service, main configuration files.
#
# Usage:
# Automatically included when you include puppet if $puppet_server_local is true or $puppet_server is equal to $fqdn
#
class puppet::server {

    # Load the variables used in this module. Check the params.pp file 
    require puppet::params

    # We need rails for storeconfigs
    case $puppet_storeconfigs {
        yes: { include puppet::rails }
        default: { }
    }

    # Automanagement of Mysql Grants if mysql is used
    if ( $puppet::params::db == "mysql" ) { include puppet::server::mysql }

    # Install Passenger if $puppet_passenger = yes 
    if ( $puppet::params::passenger == "yes" ) { include puppet::server::passenger }

    # On the PuppetMaster is useful the puppet-module-tool
    # include puppet::moduletool
    include puppet::ruby
    
    case $puppet_nodetool {
        dashboard: { include dashboard }
        foreman: { include foreman }
        default: { }
    }

    package { "puppet-server":
        name => "${puppet::params::packagename_server}",
        ensure => present;

        rrdtool-ruby:
        name => $operatingsystem ? {
            debian => "librrd-ruby",
            ubuntu => "librrd-ruby",
            default => "rrdtool-ruby",
            },
        ensure => present;
    }

    service { "puppetmaster":
        name       => "${puppet::params::servicename_server}",
        ensure     => "${puppet::params::passenger}" ? {
            yes     => undef,
            default => running,
        },
        enable     => "${puppet::params::passenger}" ? {
            yes     => false,
            default => true,
        },
        hasrestart => true,
        hasstatus  => "${puppet::params::hasstatus_server}",
        pattern    => "${puppet::params::processname_server}",
        require    => [ Package["puppet-server"] , File["puppet.conf"] ],
    }

    file { "puppet.conf":
        path    => "${puppet::params::configfile}",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package["puppet-server"],
        ensure  => present,
        content => template("puppet/server/puppet.conf.erb"),
        notify  => [ Service["puppet"], Service["puppetmaster"] ] ,
    }

    file { "namespaceauth.conf":
        path    => "${puppet::params::configdir}/namespaceauth.conf",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package["puppet-server"],
        ensure  => present,
        content => template("puppet/server/namespaceauth.conf.erb"),
        notify  => [ Service["puppet"], Service["puppetmaster"] ] ,
    }  

    file { "fileserver.conf":
        path    => "${puppet::params::configdir}/fileserver.conf",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package["puppet-server"],
        ensure  => present,
        content => template("puppet/server/fileserver.conf.erb"),
        notify  => Service["puppetmaster"] ,
    }

    file { "tagmail.conf":
        path    => "${puppet::params::configdir}/tagmail.conf",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package["puppet-server"],
        content => template("puppet/server/tagmail.conf.erb"),
    }

  if ($puppet::params::inventoryserver != "") {
    file { "auth.conf":
        path    => "${puppet::params::configdir}/auth.conf",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package["puppet-server"],
        content => template("puppet/server/auth.conf.erb"),
        notify  => Service["puppetmaster"] ,
    }
  }

    # Automatic firewalling for Puppetmaster
    if $firewall == "yes" { include puppet::firewall }

    # Include project specific class for server if $my_project is set
    if $my_project { include "puppet::${my_project}::server" }

}

