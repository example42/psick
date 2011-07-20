# Class: foreman
#
# Manages foreman.
# Include it to install and run foreman with default settings
# This class and its subclasses are based and built upon The Foreman puppet module present in the original sources  
#
# Usage:
# include foreman
#
# Variables:
# $foreman_install - Defines the installation method.
#   Can be "source" or "package" (autoselection is attempted accoring to OS)
#
class foreman {

    # Load the variables used in this module. Check the params.pp file
    require foreman::params
    include puppet::params


    # Variables used inside the module- Their values is obtained from Example42 variables scheme for puppet module
    $using_store_configs = "${puppet::params::storeconfigs}" ? {
        yes => true,
        no  => false,
    }
    
    $using_passenger = "${puppet::params::passenger}" ? {
        tofixyes => true,
        default  => false,
    }
  
  $railspath           = "${foreman::params::basedir}"
  $foreman_dir         = "${railspath}/foreman"
  $foreman_user        = "foreman"

  import "defines.pp"

  Exec {
    cwd => $foreman_dir, 
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin", 
    require => User[$foreman_user],
    user => $foreman_user,
  }

  Cron {
    require => User["$foreman_user"],
    user => $foreman_user,
    environment => "RAILS_ENV=production",
  }

  include foreman::import_facts
  include foreman::puppetca
  include foreman::puppetrun
  include foreman::tftp
  include foreman::reports
  include foreman::externalnodes

    case $foreman::params::install {
        source: { include foreman::install_from_source }
        package: { include foreman::package }
    }

    case $puppet::params::passenger {
        yes: { include foreman::passenger }
        default: { }
    }

  file{$foreman_dir: 
    ensure => directory,
    require => User[$foreman_user],
    owner => $foreman_user,
  }

  user { $foreman_user:
    shell => "/sbin/nologin",
    comment => "Foreman",
    ensure => "present",
    home => $foreman_dir,
  }
  
  
  # cleans up the session entries in the database
  # if you are using fact or report importers, this creates a session per request
  # which can easily result with a lot of old and unrequired in your database
  # eventually slowing it down.
  cron{"clear_session_table":
    command  => "(cd $foreman_dir && rake db:sessions:clear)",
    minute => "15",
    hour => "23",
  }

  cron{"daily summary":
    command  => "(cd $foreman_dir && rake reports:summarize)",
    minute => "30",
    hour => "07",
  }
}
