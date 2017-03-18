#
#
class profile::vpn::openvpn (
  String                $ensure   = 'present',
) {

  include ::openvpn

}
