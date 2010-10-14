# Class: mcollective::disableboot
#
# This class disables mcollective startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include mcollective::disableboot
#
class mcollective::disableboot inherits mcollective {
    Service["mcollective"] {
        enable => "false",
    }
}
