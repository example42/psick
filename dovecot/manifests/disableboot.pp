# Class: dovecot::disableboot
#
# This class disables dovecot startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include dovecot::disableboot
#
class dovecot::disableboot inherits dovecot {
    Service["dovecot"] {
        enable => "false",
    }
}
