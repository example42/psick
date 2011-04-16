#
# Class: mcollective::server
#
# Manages mcollective server (the agent running on each node to manage)
# It defines package, service, main configuration file.
#
# Usage:
# Automatically used when you include mcollective
#
class mcollective::server {

    # Load the variables used in this module. Check the params.pp file 
    require mcollective::params

    # Basic Package - Service - Configuration file management
    package { "mcollective":
        name     => "${mcollective::params::packagename}",
        ensure   => present,
#        require  => Package["stomp"],
    }

    package { "stomp":
        name     => "${mcollective::params::packagename_stomp}",
        ensure   => present,
    }

    service { "mcollective":
        name       => "${mcollective::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => false,
        hasstatus  => "${mcollective::params::hasstatus}",
        pattern    => "${mcollective::params::processname}",
        require    => Package["mcollective"],
        subscribe  => File["mcollective.conf"],
    }

    file { "mcollective.conf":
        path    => "${mcollective::params::configfile}",
        mode    => "${mcollective::params::configfile_mode}",
        owner   => "${mcollective::params::configfile_owner}",
        group   => "${mcollective::params::configfile_group}",
        ensure  => present,
        require => Package["mcollective"],
        notify  => Service["mcollective"],
        content => template("mcollective/server.cfg.erb"),
    }

    # Yaml based fact source for mcollective. Set $mcollective_factsource = yaml to use it (and have a lot of fun)
    file {"/etc/mcollective/facts.yaml":
        owner    => root,
        group    => root,
        mode     => 400,
        loglevel => debug,  # this is needed to avoid it being logged and reported on every run
        # avoid including highly-dynamic facts as they will cause unnecessary template writes
        content  => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>")
    }

    # Include Plugins
     if ( $mcollective::params::plugins != "no") { include mcollective::plugins }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if desired
    if $backup == "yes" { include mcollective::backup }
    if $monitor == "yes" { include mcollective::monitor }
    if $firewall == "yes" { include mcollective::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in mcollective module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::mcollective::server" }
            default: { include "mcollective::${my_project}::server" }
        }
    }

}
