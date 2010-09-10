# please follow the instructions at: http://theforeman.org/wiki/foreman/Puppet_Reports

class foreman::reports {

    include puppet::params

# foreman reporter
  file {"${puppet::params::basedir}/reports/foreman.rb":
    mode => 444,
    owner => puppet, group => puppet,
    source => "${foreman::params::foreman_source}/foreman-report.rb",
  }

  cron{"expire_old_reports":
    command  => "(cd $foreman_dir && rake reports:expire)",
    environment => "RAILS_ENV=production",
    user  => $foreman_user,
    minute => "30",
    hour => "7",
  }

}
