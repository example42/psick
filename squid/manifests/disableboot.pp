# Class: squid::disableboot
#
# This class disables squid startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include squid::disableboot
#
class squid::disableboot inherits squid {
    Service["squid"] {
        enable => "false",
    }
}
