# Class: dhcpd::disableboot
#
# This class disables dhcpd startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include dhcpd::disableboot
#
class dhcpd::disableboot inherits dhcpd {
    Service["dhcpd"] {
        enable => "false",
    }
}
