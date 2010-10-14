# Class: nrpe::disableboot
#
# This class disables nrpe startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include nrpe::disableboot
#
class nrpe::disableboot inherits nrpe {
    Service["nrpe"] {
        enable => "false",
    }
}
