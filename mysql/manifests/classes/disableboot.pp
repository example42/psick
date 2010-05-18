# Class: mysql::disableboot
#
# This class disables mysql startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include mysql::disableboot
#
class mysql::disableboot inherits mysql {
    Service["mysql"] {
        enable => "false",
    }
}
