# Class: postgresql::disableboot
#
# This class disables postgresql startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include postgresql::disableboot
#
class postgresql::disableboot inherits postgresql {
    Service["postgresql"] {
        enable => "false",
    }
}
