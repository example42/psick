# Class: tomcat::disableboot
#
# This class disables tomcat startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include tomcat::disableboot
#
class tomcat::disableboot inherits tomcat {
    Service["tomcat"] {
        enable => "false",
    }
}
