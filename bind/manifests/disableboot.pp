# Class: bind::disableboot
#
# This class disables bind startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include bind::disableboot
#
class bind::disableboot inherits bind {
    Service["bind"] {
        enable => "false",
    }
}
