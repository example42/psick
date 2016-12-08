# class to write vrrp_instance configuration
define tools::keepalived::vrrp (
  String $vip,
  Enum['present','absent'] $ensure = 'present',
  String $vip_mask     = '', # Possible values like '/24'
  Hash   $user_options = {},
  String $template     = 'profile/lb/keepalived/vrrp.conf.epp',
) {

  # Default state is based on zone and host_id
  $state = $::host_id ? {
    '1'    => $::zone ? {
      'doi'    => 'MASTER',
      'ep'     => 'MASTER',
      'mail'   => 'MASTER',
      default  => 'BACKUP',
    },
    default => $::zone ? {
      'doi'    => 'BACKUP',
      'ep'     => 'BACKUP',
      'mail'   => 'BACKUP',
      default  => 'MASTER',
    }
  }

  # Priority is based on state
  $priority = $state ? {
    'MASTER' => '150',
    'BACKUP' => '100',
  }

  # We use the last digit of the $vip for the default virtual router id 
  $vip_elements = split($vip, '[.]')

  $options_default = {
    'vrrp_instance'                           => $title,
    'vrrp_instance.state'                     => $state,
    'vrrp_instance.interface'                 => $facts['networking']['primary'],
    'vrrp_instance.lvs_sync_daemon_interface' => $facts['networking']['primary'],
    'vrrp_instance.virtual_router_id'         => $vip_elements[3],
    'vrrp_instance.priority'                  => $priority,
    'vrrp_instance.advert_int'                => '1',
    'vrrp_instance.autentication.auth_type'   => 'PASS',
    'vrrp_instance.autentication.auth_pass'   => seeded_rand(1000000000, $title),
  }

  $options = $options_default + $user_options

  $epp_options = {
    options      => $options,
    vip          => $vip,
    vip_mask     => $vip_mask,
  }

  # write vrrp_instance-configuration witch suffix "-0" for linear filelistings
  if $template != '' {
    ::tp::conf { "keepalived::vrrp_${title}":
      ensure  => $ensure,
      path    => "/etc/keepalived/services/${title}-0.conf",
      content => epp($template,$epp_options),
    }
  }

}
