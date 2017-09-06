# class profile::sensu::uchiwa
#
class profile::sensu::uchiwa (
  Stdlib::Compat::Ip_address $host = '0.0.0.0',
  Integer $port                    = 3000,
  Variant[String,Sensitive] $user  = 'sensu',
  Variant[String,Sensitive] $pass  = 'sensu',
  Hash $api_endpoints              = { },
  String $datacenter               = $::zone,
) {

  $default_api_endpoint = [ {
    name     => $datacenter,
    ssl      => false,
    host     => $::profile::sensu::api_host,
    port     => $::profile::sensu::api_port,
    user     => $::profile::sensu::api_user,
    pass     => $::profile::sensu::api_password,
    path     => '',
    timeout  => 5,
  } ]
  class { '::uchiwa':
    host                => $host,
    port                => $port,
    user                => $user,
    pass                => $pass,
    sensu_api_endpoints => $default_api_endpoint + $api_endpoints,
  }

}
