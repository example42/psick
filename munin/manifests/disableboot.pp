# Class: munin::disableboot
#
# This class disables munin startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include munin::disableboot
#
class munin::disableboot inherits munin {
    Service["munin-node"] {
        enable => "false",
    }
}
