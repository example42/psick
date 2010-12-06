# Class: sysklogd::disableboot
#
# This class disables sysklogd startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include sysklogd::disableboot
#
class sysklogd::disableboot inherits sysklogd {
    Service["sysklogd"] {
        enable => "false",
    }
}
