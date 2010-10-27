# Class: collectd::disableboot
#
# This class disables collectd startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include collectd::disableboot
#
class collectd::disableboot inherits collectd {
    Service["collectd"] {
        enable => "false",
    }
}
