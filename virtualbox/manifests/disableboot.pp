# Class: virtualbox::disableboot
#
# This class disables virtualbox startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include virtualbox::disableboot
#
class virtualbox::disableboot inherits virtualbox {
    Service["virtualbox"] {
        enable => "false",
    }
}
