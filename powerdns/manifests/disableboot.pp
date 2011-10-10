# Class: powerdns::disableboot
#
# This class disables powerdns startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include powerdns::disableboot
#
class powerdns::disableboot inherits powerdns {
    Service["powerdns"] {
        enable => "false",
    }
}
