# Disables iptables (no boot, no run)

class iptables::disable inherits iptables {
        Service ["iptables"] {
                ensure => stopped,
                enable => false,
        }
}
