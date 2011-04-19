# Class: cobbler::disableboot
#
# This class disables cobbler startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include cobbler::disableboot
#
class cobbler::disableboot inherits cobbler {
    Service["cobbler"] {
        enable => "false",
    }
}
