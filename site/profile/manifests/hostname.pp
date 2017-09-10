# This class manages an host hostname
# It supports hostname preservation on cloud instances by
# setting update_cloud_cfg to true (Needs cloud-init installed)
#
class profile::hostname (
  String                $host                 = $::hostname,
  Variant[Undef,String] $dom                  = $::domain,
  String                $ip                   = $::ipaddress,
  Boolean               $update_host_entry    = true,
  Boolean               $update_network_entry = true,
  Boolean               $update_cloud_cfg     = false,
  ) {

  if ($dom) and $dom != '' {
    $calc_fqdn = "${host}.${dom}"
  } else {
    $calc_fqdn = $host
  }

  case $::kernel {
    'Linux': {
      if $::virtual != 'docker' {
        file { '/etc/hostname':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => "${calc_fqdn}\n",
          notify  => Exec['apply_hostname'],
        }
    
        exec { 'apply_hostname':
          command => '/bin/hostname -F /etc/hostname',
          unless  => '/usr/bin/test `hostname` = `/bin/cat /etc/hostname`',
        }
    
        if $update_host_entry {
          host { $host:
            ensure       => present,
            host_aliases => $calc_fqdn,
            ip           => $ip,
          }
        }
    
        if $update_network_entry {
          case $::osfamily {
            'RedHat': {
              file { '/etc/sysconfig/network':
                ensure  => file,
                content => "NETWORKING=yes\nNETWORKING_IPV6=no\nHOSTNAME=${calc_fqdn}\n",
                notify  => Exec['apply_hostname'],
              }
            }
            default: {}
          }
        }
    
        if $update_cloud_cfg {
          file { '/etc/cloud/cloud.cfg.d/99_preserve_hostname.cfg':
            ensure  => file,
            content => "preserve_hostname: true\n",
            notify  => Exec['apply_hostname'],
          }
        }
      }
    }
    'windows': {
      registry_value { 'HKLM\System\CurrentControlSet\Control\ComputerName\ActiveComputerName':
        ensure => 'present',
        type   => string,
        data   => $host,
      }
      registry_value { 'HKLM\System\CurrentControlSet\Control\ComputerName\ComputerName':
        ensure => 'present',
        type   => string,
        data   => $host,
      }
    }
    default: {
      notice("profile::hostname does not support $::kernel")
    }
  }
}
