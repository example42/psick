# Class: ntp::disableboot
#
# This class disables ntp startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include ntp::disableboot
#
class ntp::disableboot inherits ntp {
    Service["ntp"] {
        enable => "false",
    }
}
