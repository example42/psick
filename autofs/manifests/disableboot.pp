# Class: autofs::disableboot
#
# This class disables autofs startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include autofs::disableboot
#
class autofs::disableboot inherits autofs {
    Service["autofs"] {
        enable => "false",
    }
}
