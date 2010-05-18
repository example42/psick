# Class: postfix::disableboot
#
# This class disables postfix startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include postfix::disableboot
#
class postfix::disableboot inherits postfix {
    Service["postfix"] {
        enable => "false",
    }
}
