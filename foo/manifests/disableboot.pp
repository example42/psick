# Class: foo::disableboot
#
# This class disables foo startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include foo::disableboot
#
class foo::disableboot inherits foo {
    Service["foo"] {
        enable => "false",
    }
}
