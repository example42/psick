# Class: openvpn::disableboot
#
# This class disables openvpn startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include openvpn::disableboot
#
class openvpn::disableboot inherits openvpn {
    Service["openvpn"] {
        enable => "false",
    }
}
