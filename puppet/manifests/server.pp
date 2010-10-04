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

    # Resets variables needed in templates (to get deault values)
    $puppet_server = $puppet::params::server
    $puppet_allow = $puppet::params::allow
    $puppet_nodetool = $puppet::params::nodetool
    $puppet_externalnodes = $puppet::params::externalnodes
    $puppet_storeconfigs = $puppet::params::storeconfigs
    $puppet_db = $puppet::params::db
    $puppet_db_server = $puppet::params::db_server
    $puppet_db_user = $puppet::params::db_user
    $puppet_db_password = $puppet::params::db_password
    $puppet_version = $puppet::params::version

    # We need rails for storeconfigs
    case $puppet_storeconfigs {
        yes: { include rails }
        default: { }
    }

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
        ensure     => running,
        enable     => true,
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

    file { "tagmail.conf":
        path    => "${puppet::params::configdir}/tagmail.conf",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package["puppet-server"],
        content => template("puppet/server/tagmail.conf.erb"),
    }


    # Include project specific class
    if $my_project {
        case $my_project_onmodule {
            yes,true: { include "${my_project}::puppet::server" }
            default: { include "puppet::server::${my_project}" }
        }
    }

}

