# Class used as entry point to set general settings used by other profiles
#
# @param is_cluster Defines if the server is a cluster member
# @param primary_ip_address The server primary IP address. Default value is
#                           automatically calculated based on the mgmt_interface
#                           address. The resulting variable, used in other
#                           profiles is profile::settings::primary_ip
# @param mgmt_interface # The management interface of the server.
# @param timezone The timezone to set on the system
# @param proxy_server An hash describing the proxy server to use. This data is
#                     used by profile::proxy and any other class which needs
#                     proxy information
#
# @example Sample data for proxy server hash
# profile::settings::proxy_server:
#   host: proxy.example.com
#   port: 3128
#   user: john    # Optional
#   password: xxx # Optional
#   no_proxy:
#     - localhost
#     - "%{::domain}"
#   scheme: http
#
class profile::settings (
  Boolean $is_cluster         = false,
  Stdlib::Compat::Ip_address $primary_ip_address = '255.255.255.255',
  String  $mgmt_interface     = $facts['networking']['primary'],

  Optional[String] $timezone  = '',

  Optional[Profile::Serverhash] $proxy_server = {},

  Boolean $tp_test            = false,
  Boolean $firewall_enable    = false,
  Boolean $firewall_manage    = false,
  Boolean $monitor_enable     = true,
  Boolean $monitor_manage     = true,

) {

  $primary_ip = $primary_ip_address ? {
    '255.255.255.255' => $facts['networking']['interfaces'][$mgmt_interface]['ip'],
    default           => $primary_ip_address,
  }

}
