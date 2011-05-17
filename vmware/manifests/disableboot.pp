# Class: vmware::disableboot
#
# This class disables vmware startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include vmware::disableboot
#
class vmware::disableboot inherits vmware {
    Service["vmware"] {
        enable => "false",
    }
}
