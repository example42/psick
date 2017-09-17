#
#
class psick::vpn::openvpn (
  String                $ensure   = 'present',
) {

  include ::openvpn

}
