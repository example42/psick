# Class: openssh::disableboot
#
# This class disables openssh startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include openssh::disableboot
#
class openssh::disableboot inherits openssh {
    Service["openssh"] {
        enable => "false",
    }
}
