# Class: dashboard::disableboot
#
# This class disables dashboard startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include dashboard::disableboot
#
class dashboard::disableboot inherits dashboard {
    Service["dashboard"] {
        enable => "false",
    }
}
