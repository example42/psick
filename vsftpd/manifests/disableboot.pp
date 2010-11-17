# Class: vsftpd::disableboot
#
# This class disables vsftpd startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include vsftpd::disableboot
#
class vsftpd::disableboot inherits vsftpd {
    Service["vsftpd"] {
        enable => "false",
    }
}
