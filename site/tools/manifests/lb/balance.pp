# Define to apply to balanced servers
#
define tools::lb::balance (
  String $vip,
  Array $ports,
  Enum['present','absent'] $ensure = 'present',
  Hash   $lb_options = {},
  Optional[String] $lb_template = undef,
  String $lb_type  = 'keepalived',
  Boolean $direct_response = false,
  # If false routing for replies is expected to pass through the LB
  # (direct-responses-route)
) {

  $template = $lb_template ? {
    undef   => $lb_type ? {
      'keepalived' => 'profile/lb/keepalived/rs.conf.epp',
      default      => undef,
    },
    default => $lb_template,
  }

  # start KeepAlived/LVS
  if $lb_type == 'keepalived' {
    # default opts depending on serviceprotocol to balance
    $real_servers_defaults_http_get = {
      'url'                => true,
      'paths'              => ['/'],
      'status_code'        => '200',
      'nb_get_retries'     => '3',
      'delay_before_retry' => '3',
      'connect_timeout'    => '10',
      'healthchecker'      => 'HTTP_GET',
    }
    $real_servers_defaults_tcp_check = {
      'connect_timeout'    => '10',
      'healthchecker'      => 'TCP_CHECK',
    }
    $real_servers_defaults_smtp_check = {
      'connect_timeout'    => '10',
      'retry'              => '3',
      'delay_before_retry' => '3',
      'helo_name'          => $::fqdn,
      'healthchecker'      => 'SMTP_CHECK',
    }
    $real_servers_defaults_misc_check = {
      'misc_timeout'       => '10',
      'healthchecker'      => 'MISC_CHECK',
    }
    # General defaults

    $lb_servicename = "${::zone}-${title}-${::env}-${::gen}"
    $ports.each | String $port_type , Integer $port | {
      $real_servers_defaults = {
        'weight'             => '1',
        'ip'                 => $::ipaddress,
        'port'               => $port,
      }
      $epp_options = {
        options      => $port_type ? {
          'http'  => $real_servers_defaults + $real_servers_defaults_http_get + $lb_options,
          'https' => $real_servers_defaults + $real_servers_defaults_http_get + $lb_options,
          'smtp'  => $real_servers_defaults + $real_servers_defaults_smtp_check + $lb_options,
          default => $real_servers_defaults + $real_servers_defaults_tcp_check + $lb_options,
        },
      }
      @@concat::fragment { "${::fqdn}-${lb_servicename}-${port}_real_server":
        target  => "/etc/keepalived/services/${lb_servicename}-${port}.conf",
        order   => '20',
        content => epp($template,$epp_options),
        tag     => "lb_${::zone}-${::env}",
      }
    }
  } # end KeepAlived/LVS

  if $direct_response {
    # Manage VIP on loopback interface
    # write helperfile for vip to bind on loopback
    tools::network::set_lo_ip { $vip: }

    $lb_sysctl_settings = {
      'ipv4-arp' => {
        'net.ipv4.conf.default.arp_ignore' => 1,
        'net.ipv4.conf.default.arp_announce' => 2,
        'net.ipv4.conf.all.arp_ignore' => 1,
        'net.ipv4.conf.all.arp_announce' => 2,
      },
    }

    tools::sysctl { 'lb_sysctl_settings':
      sysctl_options => $lb_sysctl_settings,
    }
  }

}
