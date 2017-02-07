# This class installs the packages needed for HP tools on HP hardware
# and starts the relevant services.
# It also add sudo directives for the hpsmh group
#
class profile::hardware::hp (
  Array $packages,
) {
  $packages.each |$pkg| {
    ensure_packages($pkg)
  }

  service { 'hp-asrd':
    ensure => 'stopped',
    enable => false,
  }
  service { 'hp-health':
    ensure => 'running',
    enable => true,
  }
  service { 'hp-snmp-agents':
    ensure => 'running',
    enable => true,
  }

  tools::sudo::directive { 'hp':
    source => 'puppet:///modules/profile/sudo/hp',
  }

}
