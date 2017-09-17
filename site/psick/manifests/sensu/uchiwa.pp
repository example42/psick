# class psick::sensu::uchiwa
#
class psick::sensu::uchiwa (
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
    host     => $::psick::sensu::api_host,
    port     => $::psick::sensu::api_port,
    user     => $::psick::sensu::api_user,
    pass     => $::psick::sensu::api_password,
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
