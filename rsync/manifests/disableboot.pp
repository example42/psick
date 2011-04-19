# Class: rsync::disableboot
#
# This class disables rsync startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include rsync::disableboot
#
class rsync::disableboot inherits rsync {
    Service["rsync"] {
        enable => "false",
    }
}
