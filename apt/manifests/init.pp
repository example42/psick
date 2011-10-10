#
# Class: apt
#
# Manages apt.
# Include it to install and run apt
# It defines package, service, main configuration file.
#
# Usage:
# include apt
#
class apt {

    # Load the variables used in this module. Check the params.pp file 
    require apt::params

    # Basic Package - Service - Configuration file management
    package { "apt":
        name   => "${apt::params::packagename}",
        ensure => present,
    }

    file { 
      "apt.conf":
        path    => "${apt::params::configfile}",
        mode    => "${apt::params::configfile_mode}",
        owner   => "${apt::params::configfile_owner}",
        group   => "${apt::params::configfile_group}",
        ensure  => present,
    }
    file {
      "sources.list.d":
        path    => "${apt::params::sourcelistdir}",
        mode    => "${apt::params::configdir_mode}",
        owner   => "${apt::params::configfile_owner}",
        group   => "${apt::params::configfile_group}",
        ensure  => present,
    }
    file {
      "sources.list":
        path    => "${apt::params::sourcelist}",
        mode    => "${apt::params::configfile_mode}",
        owner   => "${apt::params::configfile_owner}",
        group   => "${apt::params::configfile_group}",
        ensure  => present,
    }
    
    exec {
        aptget_update:
            command     => "${apt::params::update_command}",
            logoutput   => false,
            refreshonly => true,
            subscribe   => [File["sources.list"], 
                            File["sources.list.d"], 
                            File["apt.conf"]];
    }
    
    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }
    # apt support preferences.d since version >= 0.7.22
    case $lsbdistcodename {
      /lucid|squeeze/ : {

        file {"/etc/apt/preferences":
          ensure => absent,
        }

        file {"/etc/apt/preferences.d":
          ensure  => directory,
          owner   => root,
          group   => root,
          mode    => 755,
          recurse => "${apt::params::manage_preferences}",
          purge   => "${apt::params::manage_preferences}",
          force   => "${apt::params::manage_preferences}",
        }
      }
    }

#    file { "/etc/apt/sources.list.d":
#      ensure  => directory,
#      source  => "puppet:///apt/empty/",
#      recurse => "${apt::params::manage_sourceslist}",
#      purge   => "${apt::params::manage_sourceslist}",
#      force   => "${apt::params::manage_sourceslist}",
#      ignore  => ".placeholder",
#    }

    
    # Include project specific class if $my_project is set
    if $my_project { include "apt::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    #if $puppi == "yes" { include apt::puppi }
    #if $backup == "yes" { include apt::backup }
    #if $monitor == "yes" { include apt::monitor }
    #if $firewall == "yes" { include apt::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    #if ( $debug == "yes" ) or ( $debug == true ) { include apt::debug }

}
