# Class: exim::disableboot
#
# This class disables exim startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include exim::disableboot
#
class exim::disableboot inherits exim {
    Service["exim"] {
        enable => "false",
    }
}
