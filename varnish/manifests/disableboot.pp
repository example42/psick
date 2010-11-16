# Class: varnish::disableboot
#
# This class disables varnish startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include varnish::disableboot
#
class varnish::disableboot inherits varnish {
    Service["varnish"] {
        enable => "false",
    }
}
