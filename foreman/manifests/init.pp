class foreman {

  # default variables 
  $using_store_configs = true # true or false
  $using_passenger     = false  # true or false

  $railspath           = "/usr/share"
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

  # Current package is available for Red Hat 5
  if $lsbmajdistrelease == "5" {
    include foreman::package
    # passenger setup for Red Hat 5
    include foreman::passenger
  } else {
    include foreman::install_from_source
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
