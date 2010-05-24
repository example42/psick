# Class: clamav::disableboot
#
# This class disables clamav startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include clamav::disableboot
#
class clamav::disableboot inherits clamav {
    Service["clamav"] {
        enable => "false",
    }
}
