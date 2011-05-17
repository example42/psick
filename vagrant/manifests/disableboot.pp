# Class: vagrant::disableboot
#
# This class disables vagrant startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include vagrant::disableboot
#
class vagrant::disableboot inherits vagrant {
    Service["vagrant"] {
        enable => "false",
    }
}
