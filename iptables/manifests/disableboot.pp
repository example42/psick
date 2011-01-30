# Class: iptables::disableboot
#
# This class disables iptables startup at boot time but doesn't check if the service is running
#
# Usage:
# include iptables::disableboot
#
class iptables::disableboot inherits iptables::base {
    Service["iptables"] {
        enable => "false",
    }
}
