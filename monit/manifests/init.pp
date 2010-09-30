# Class: monit
#
# Manages monit.
# Include it to install and run monit with default settings
#
# Usage:
# include monit


class monit {
    
    require monit::params

    $monit_interval = $monit::params::interval
    $monit_mailserver = $monit::params::mailserver
    $monit_alert = $monit::params::alert
    $monit_startup = $monit::params::startup

    package { "monit":
        name   => "${monit::params::packagename}",
        ensure => present,
    }

    service { "monit":
        name       => "${monit::params::servicename}",
        ensure     => running,
        enable     => true,
        pattern    => "${monit::params::servicepattern}",
        hasrestart => true,
	hasstatus  => "${monit::params::hasstatus}",
        require    => Package["monit"],
        subscribe  => [File["monitrc"], File["monit-initdconfig"]]
    }

    file { "monitrc":
        path    => "${monit::params::configfile}",
        mode    => "${monit::params::configfile_mode}",
        owner   => "${monit::params::configfile_owner}",
        group   => "${monit::params::configfile_group}",
        require => Package["monit"],
        ensure  => present,
	content => template("monit/monitrc.erb"),
    }

    file { "/etc/monit.d":
        path    => "${monit::params::pluginsdir}",
        mode    => "${monit::params::pluginsdir_mode}",
        owner   => "${monit::params::pluginsdir_owner}",
        group   => "${monit::params::pluginsdir_group}",
        require => Package["monit"],
        ensure  => directory,
    }

    file { "monit-initdconfig":
        path    => "${monit::params::initdconfigfile}",
        mode    => "${monit::params::initdconfigfile_mode}",
        owner   => "${monit::params::initdconfigfile_owner}",
        group   => "${monit::params::initdconfigfile_group}",
        require => Package["monit"],
        ensure  => present,
	content => template("monit/monit-initdconfig.erb"),
    }

#    if $backup == "yes" { include monit::backup }
#    if $monitor == "yes" { include monit::monitor }
#    if $firewall == "yes" { include monit::firewall }

# Autoloads monit::$my_project if $my_project is defined
# Place in monit::$my_project your customizatios
    if $my_project { include "monit::${my_project}" }

}
