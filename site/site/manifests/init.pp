class site (
  $pre_class         = '::site::pre',

  $general_class     = '::site::general',

  $puppet_class      = '',

  $network_class     = '::site::network',
  $users_class       = '::site::users',
  $monitor_class     = '::site::monitor',
  $firewall_class    = '::site::firewall',
  $backup_class      = '',
  $logs_class        = '::site::logs',

) {

  if $pre_class and $pre_class != '' {
    include $pre_class
  }

  if $network_class and $network_class != '' {
    class { $network_class:
      require => Class[$pre_class],
    }
  }

  if $general_class and $general_class != '' {
    class { $general_class:
      require => Class[$pre_class],
    }
  }

  if $puppet_class and $puppet_class != '' {
    class { $puppet_class:
      require => Class[$pre_class],
    }
  }

  if $monitor_class and $monitor_class != '' {
    class { $monitor_class:
      require => Class[$pre_class],
    }
  }

  if $backup_class and $backup_class != '' {
    class { $backup_class:
      require => Class[$pre_class],
    }
  }

  if $users_class and $users_class != '' {
    class { $users_class:
      require => Class[$pre_class],
    }
  }

  if $firewall_class and $firewall_class != '' {
    class { $firewall_class:
      require => Class[$pre_class],
    }
  }

  if $logs_class and $logs_class != '' {
    class { $logs_class:
      require => Class[$pre_class],
    }
  }


  # Role specific class is loaded, if $role is set
  if $::role and $::role != '' {
    class { "::site::role::${::role}":
      require => Class[$pre_class],
    }
  }
}
