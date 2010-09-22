# Class: apache::disableboot
#
# This class disables apache startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include apache::disableboot
#
class apache::disableboot inherits apache {
    Service["apache"] {
        enable => "false",
    }
}
