class foreman::passenger {
  if $using_passenger {
    include apache2::passenger
    include apache2::ssl
  }

  file{"foreman_vhost":
    path => $lsbdistid ? {
      default => "/etc/httpd/conf.d/foreman.conf",
      "Ubuntu" => "/etc/apache2/conf.d/foreman.conf"
    },
    content => template("foreman/foreman-vhost.conf.erb"),
    mode => 644,
    notify => $using_passenger ? {
      true => Exec["reload-apache2"],
      default => undef,
    },
    ensure => $using_passenger ? {
      true => "present",
      default => "absent",
    },
  }

  exec{"restart_foreman":
    command => "/bin/touch $foreman_dir/tmp/restart.txt",
    refreshonly => true
  }

}
