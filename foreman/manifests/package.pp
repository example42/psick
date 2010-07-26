class foreman::package {

  yumrepo { "foreman":
    descr => "Foreman Repo",
    baseurl => "http://theforeman.org/repo",
    gpgcheck => "0",
    enabled => "1"
  }

  package{"foreman":
    ensure => installed,
    require => Yumrepo["foreman"],
    notify => Service["foreman"],
  }

  service {"foreman":
    ensure => $using_passenger ? {
      true => "stopped",
      false => "running"
    },
    enable => $using_passenger ? {
      true => "false",
      false => "true",
    },
    hasstatus => true,
  }
}
