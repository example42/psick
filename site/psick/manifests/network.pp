# This class manages network configurations
#
# @param bonding_mode Define bonding mode (default: active-backup)
# @param network_template The erb template to use, only on RedHad derivatives,
#                         for the file /etc/sysconfig/network
# @param routes Hash of routes to pass to ::network::mroute define
#               Note: This is not a real class parameter but a key looked up
#               via hiera_hash('psick::network::routes', {})
# @param interfaces Hash of interfaces to pass to ::network::interface define
#                   Note: This is not a real class parameter but a key looked up
#                   via hiera_hash('psick::network::interfaces', {})
#                   Note that this psick automatically adds some default
#                   options according to the interface type. You can override
#                   them in the provided hash
#
class psick::network (
  String $bonding_mode     = 'active-backup',
  String $network_template = 'psick/network/network.erb',
) {

  include ::network

  file { '/etc/modprobe.d/bonding.conf':
    ensure => file,
  }
  $routes = hiera_hash('psick::network::routes', {})
  $routes.each |$r,$o| {
    ::network::mroute { $r:
      routes => $o[routes],
    }
  }
  $default_options = {
    onboot     => 'yes',
    'type'     => 'Ethernet',
    template   => "psick/network/interface-${::osfamily}.erb",
    options    => {
      'IPV6INIT'           => 'no',
      'IPV4_FAILURE_FATAL' => 'yes',
    },
    bootproto  => 'none',
    nozeroconf => 'yes',
  }
  $default_bonding_options = {
    'type'         => 'Bond',
    bonding_opts   => "resend_igmp=1 updelay=30000 use_carrier=1 miimon=100 downdelay=100 xmit_hash_policy=0 primary_reselect=0 fail_over_mac=0 arp_validate=0 mode=${bonding_mode} arp_interval=0 ad_select=0",
    bonding_master => 'yes',
  }
  $interfaces = hiera_hash('psick::network::interfaces', {})
  $interfaces.each |$r,$o| {
    if $r =~ /^bond/ {
      $options = $default_options + $default_bonding_options + $o
      file_line { "bonding.conf ${r}":
        line    => "alias netdev-${r} bonding",
        path    => '/etc/modprobe.d/bonding.conf',
        require => File['/etc/modprobe.d/bonding.conf'],
      }
    } else {
      $options = $default_options + $o
    }
    ::network::interface { $r:
      * => $options,
    }
  }

  if $::osfamily == 'RedHat'
  and $network_template != ''
  and $::profile::base::linux::hostname_class != '' {
    file { '/etc/sysconfig/network':
      ensure  => file,
      content => template($network_template),
    }
  }
}
