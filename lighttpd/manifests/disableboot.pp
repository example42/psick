# Class: lighttpd::disableboot
#
# This class disables lighttpd startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include lighttpd::disableboot
#
class lighttpd::disableboot inherits lighttpd {
    Service["lighttpd"] {
        enable => "false",
    }
}
