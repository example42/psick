class foreman::import_facts {

  file {"/etc/puppet/push_facts.rb":
    mode => 555,
    owner => puppet, group => puppet,
    source => "puppet:///foreman/push_facts.rb",
    ensure => $using_store_configs ? {
      true => "absent",
      false => "present"
    },
  }

  cron{"send_facts_to_foreman":
    command  => "/etc/puppet/push_facts.rb",
    user  => "puppet",
    minute => "*/2",
    ensure => $using_store_configs ? {
      true => "absent",
      false => "present"
    },
  }

  cron{"populate_hosts":
    command  => "(cd $foreman_dir && rake puppet:migrate:populate_hosts)",
    environment => "RAILS_ENV=production",
    user => $foreman_user,
    minute => "*/30",
    ensure => $using_store_configs ? {
      true => "present",
      false => "absent"
    },
  }

}
