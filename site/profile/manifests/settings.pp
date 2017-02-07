# Class used to set general settings used by other profiles
#
# @param is_cluster Defines if the server is a cluster member
# @param primary_ip_address The server primary IP address. Default value is
#                           automatically calculated based on the mgmt_interface
#                           address. The resulting variable, used in other
#                           profiles is profile::settings::primary_ip
# @param mgmt_interface # The management interface of the server.
#
class profile::settings (
  Boolean $is_cluster         = false,
  String  $primary_ip_address = '',
  String  $mgmt_interface     = $facts['networking']['primary'],
) {

  $primary_ip = $primary_ip_address ? {
    ''      => $facts['networking']['interfaces'][$mgmt_interface]['ip'],
    default => $primary_ip_address,
  }
}
