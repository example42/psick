class foreman::package::redhat {

  include yum::repo::foreman
#  include yum::repo::rbel

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
