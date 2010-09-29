# Class: snmpd::disableboot
#
# This class disables snmpd startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include snmpd::disableboot
#
class snmpd::disableboot inherits snmpd {
    Service["snmpd"] {
        enable => "false",
    }
}
