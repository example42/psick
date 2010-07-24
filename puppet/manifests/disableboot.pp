# Class: puppet::disableboot
#
# This class disables puppet startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include puppet::disableboot
#
class puppet::disableboot inherits puppet {
    Service["puppet"] {
        enable => "false",
    }
}
