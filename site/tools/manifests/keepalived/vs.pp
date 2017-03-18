# class to write virtual_server configuration
define tools::keepalived::vs (
  String $vip,
  Integer $vip_port,
  Enum['present','absent'] $ensure = 'present',
  Hash   $user_options    = {},
  String $template        = 'profile/lb/keepalived/vs.conf.epp',
  Optional[Hash] $servers = undef,
) {

  # We use the last digit of the $vip for the default virtual router id 
  $vip_elements = split($vip, '[.]')

  $options_default = {
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
    vip          => $vip,
    vip_port     => $vip_port,
  }

  concat { "/etc/keepalived/services/${title}.conf":
    ensure => $ensure,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }

  concat::fragment { "${title}_header.conf":
    target  => "/etc/keepalived/services/${title}.conf",
    order   => '01',
    content => epp($template,$epp_options),
  }
  concat::fragment { "${title}_footer.conf":
    target  => "/etc/keepalived/services/${title}.conf",
    order   => '99',
    content => "}\n",
  }
}
