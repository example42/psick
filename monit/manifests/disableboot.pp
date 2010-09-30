# Class: monit::disableboot
#
# This class disables monit startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include monit::disableboot
#
class monit::disableboot inherits monit {
    Service["monit"] {
        enable => "false",
    }
}
