#
# Class: rsync
#
# Manages rsync.
# Include it to install and run rsync
# It defines package, service, main configuration file.
#
# Usage:
# include rsync
#
class rsync {

    # Load the variables used in this module. Check the params.pp file 
    require rsync::params

    # Basic Package - Service - Configuration file management
    package { "rsync":
        name   => "${rsync::params::packagename}",
        ensure => present,
    }

    service { "rsync":
        name       => "${rsync::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${rsync::params::hasstatus}",
        pattern    => "${rsync::params::processname}",
        require    => Package["rsync"],
        subscribe  => File["rsync.conf"],
    }

    file { "rsync.conf":
        path    => "${rsync::params::configfile}",
        mode    => "${rsync::params::configfile_mode}",
        owner   => "${rsync::params::configfile_owner}",
        group   => "${rsync::params::configfile_group}",
        ensure  => present,
        require => Package["rsync"],
        notify  => Service["rsync"],
        # content => template("rsync/rsync.conf.erb"),
    }


  case $operatingsystem {
    /(CentOS|RedHat)/: {  
      file { "rsync.init":
        path    => "/etc/rc.d/init.d/rsync",
        mode    => "755",
        owner   => "${rsync::params::configfile_owner}",
        group   => "${rsync::params::configfile_group}",
        ensure  => present,
        require => Package["rsync"],
        notify  => Service["rsync"],
        source  => "puppet:///rsync/rsync.init",
      }
    }
      default: { }
  }

    # Include project specific class if $my_project is set
    if $my_project { include "rsync::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include rsync::puppi }
    if $backup == "yes" { include rsync::backup }
    if $monitor == "yes" { include rsync::monitor }
    if $firewall == "yes" { include rsync::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include rsync::debug }

}
