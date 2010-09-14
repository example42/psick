# Class: openntpd::disableboot
#
# This class disables openntpd startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include openntpd::disableboot
#
class openntpd::disableboot inherits openntpd {
    Service["openntpd"] {
        enable => "false",
    }
}
