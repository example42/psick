# Class: samba::disableboot
#
# This class disables samba startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include samba::disableboot
#
class samba::disableboot inherits samba {
    Service["samba"] {
        enable => "false",
    }
}
