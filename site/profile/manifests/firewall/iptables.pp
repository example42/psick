# Essential firewall class based on simple iptables-save file
#
class profile::firewall::iptables (
  String $rules_template                 = 'profile/firewall/iptables.erb',
  Array $extra_rules                     = [ ],
  Array $allowall_interfaces             = [ ],
  Array $allow_tcp_ports                 = [ ],
  Array $allow_udp_ports                 = [ ],
  Boolean $ssh_safe_mode                 = true,
  Enum['DROP','ACCEPT'] $default_input   = 'DROP',            
  Enum['DROP','ACCEPT'] $default_output  = 'ACCEPT',            
  Enum['DROP','ACCEPT'] $default_forward = 'ACCEPT',            
  String $package_name,
  String $service_name,
  String $config_file_path,
) {

  package { $package_name:
    ensure => present,
    before => Service[$service_name],
  }

  file { $config_file_path:
    ensure  => present,
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
        ensure  => present,
        content => template('profile/firewall/iptables.service.erb'),
        notify  => Service[$service_name],
      }
      file { '/etc/sysconfig/iptables.stop':
        ensure  => present,
        content => template('profile/firewall/iptables.stop.erb'),
        notify  => Service[$service_name],
      }
      package { 'SuSEfirewall2':
        ensure => absent,
      }
    }
    default: {}
  }

}
