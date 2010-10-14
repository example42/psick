# Class: activemq::disableboot
#
# This class disables activemq startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include activemq::disableboot
#
class activemq::disableboot inherits activemq {
    Service["activemq"] {
        enable => "false",
    }
}
