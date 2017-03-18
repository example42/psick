#
define tools::keepalived::virtualserver_static (
  String $vip,
  Array  $vip_port,
  Enum['present','absent'] $ensure = 'present',
  Enum['MASTER','BACKUP'] $state = 'MASTER',
  String $pql_query    = '',
  String $vip_mask     = '', # Possible values like '/24'
  Hash   $user_options = {},
  String $template     = 'profile/lb/keepalived/services.conf.epp',
  Optional[Hash] $servers = undef,
) {

  # Priority is based on state
  $priority = $state ? {
    'MASTER' => '150',
    'BACKUP' => '100',
  }

  # We use the last digit of the $vip for the default virtual router id 
  $vip_elements = split($vip, '[.]')

  # Some default settings according to the service check type
  $real_servers_defaults_http_get = {
    'url'                => true,
    'paths'              => ['/'],
    'status_code'        => '200',
    'nb_get_retries'     => '3',
    'delay_before_retry' => '3',
    'connect_timeout'    => '10',
  }
  $real_servers_defaults_tcp_check = {
    'connect_timeout'    => '10',
  }
  $real_servers_defaults_smtp_check = {
    'connect_timeout'    => '10',
    'retry'              => '3',
    'delay_before_retry' => '3',
    'helo_name'          => $::fqdn,
  }
  $real_servers_defaults_misc_check = {
    'misc_timeout'       => '10',
  }
  # General defaults 
  $real_servers_defaults = {
    'weight'             => '1',
  }

  $auto_servers = $pql_query ? {
    ''      => {},
    default => puppetdb_query($pql_query),
  }

  $real_servers = $servers ? {
    undef   => $auto_servers,
    default => $servers,
  }

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
    'virtual_server.delay_loop'               => '30',
    'virtual_server.lb_algo'                  => 'rr',
    'virtual_server.lb_kind'                  => 'DR',
    'virtual_server.persistence_timeout'      => '1800',
    'virtual_server.protocol'                 => 'TCP',
    'virtual_server.sorry_server'             => '127.0.0.1',
  }

  $options = $options_default + $user_options

  $epp_options = {
    options      => $options,
    real_servers => $real_servers,
    vip          => $vip,
    vip_port     => $vip_port,
    vip_mask     => $vip_mask,
  }

  if $template != '' {
    ::tp::conf { "keepalived::service_${title}":
      ensure  => $ensure,
      path    => "/etc/keepalived/services/${title}.conf",
      content => epp($template,$epp_options),
    }
  }

}
