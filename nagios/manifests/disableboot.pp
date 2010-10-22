# Class: nagios::disableboot
#
# This class disables nagios startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include nagios::disableboot
#
class nagios::disableboot inherits nagios {
    Service["nagios"] {
        enable => "false",
    }
}
