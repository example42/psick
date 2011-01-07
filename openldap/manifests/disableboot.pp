# Class: openldap::disableboot
#
# This class disables openldap startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include openldap::disableboot
#
class openldap::disableboot inherits openldap {
    Service["openldap"] {
        enable => "false",
    }
}
