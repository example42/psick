# Class: portmap::disableboot
#
# This class disables portmap startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include portmap::disableboot
#
class portmap::disableboot inherits portmap {
    Service["portmap"] {
        enable => "false",
    }
}
