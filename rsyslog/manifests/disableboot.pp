# Class: rsyslog::disableboot
#
# This class disables rsyslog startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include rsyslog::disableboot
#
class rsyslog::disableboot inherits rsyslog {
    Service["rsyslog"] {
        enable => "false",
    }
}
