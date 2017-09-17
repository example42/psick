# Essential firewall class based on simple iptables-save file
#
class psick::firewall::iptables (
  String $package_name,
  String $service_name,
  String $config_file_path,
  String $rules_template                 = 'psick/firewall/iptables.erb',
  Array $extra_rules                     = [ ],
  Array $allowall_interfaces             = [ ],
  Array $allow_tcp_ports                 = [ ],
  Array $allow_udp_ports                 = [ ],
  Boolean $ssh_safe_mode                 = true,
  Enum['DROP','ACCEPT'] $default_input   = 'DROP',
  Enum['DROP','ACCEPT'] $default_output  = 'ACCEPT',
  Enum['DROP','ACCEPT'] $default_forward = 'ACCEPT',
) {

  package { $package_name:
    ensure => present,
    before => Service[$service_name],
  }

  file { $config_file_path:
    ensure  => file,
    notify  => Service[$service_name],
    content => template($rules_template),
    mode    => '0640',
  }

  service { $service_name:
    ensure => running,
    enable => true,
  }

  case $::osfamily {
    'RedHat': {
      package { 'firewalld':
        ensure => absent,
      }
    }
    'Debian': {
      file { '/etc/iptables':
        ensure => directory,
      }
    }
    'Suse': {
      file { '/usr/lib/systemd/system/iptables.service':
        ensure  => file,
        content => template('psick/firewall/iptables.service.erb'),
        notify  => Service[$service_name],
      }
      file { '/etc/sysconfig/iptables.stop':
        ensure  => file,
        content => template('psick/firewall/iptables.stop.erb'),
        notify  => Service[$service_name],
      }
      package { 'SuSEfirewall2':
        ensure => absent,
      }
    }
    default: {}
  }

}
