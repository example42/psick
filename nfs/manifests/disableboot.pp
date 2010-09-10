# Class: nfs::disableboot
#
# This class disables nfs startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include nfs::disableboot
#
class nfs::disableboot inherits nfs::server {
    Service["nfs"] {
        enable => "false",
    }
}
