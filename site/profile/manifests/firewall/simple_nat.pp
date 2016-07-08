# Simple profile to manage a NAT server that allow full
# access from the specified $source_net.
#
# This profile needs the following modules:
# example42/sysctl
# puppetlabs/firewall
#
class profile::firewall::simple_nat (
  $source_net = "${::network}/${::netmask}",
) {

  sysctl::value { '/proc/sys/net/ipv4/ip_forward': value => '1'}
  firewall { "100 snat for network ${source_net}":
    chain  => 'POSTROUTING',
    jump   => 'MASQUERADE',
    proto  => 'all',
    source => $source_net,
    table  => 'nat',
  }
  firewall { "100 forward for network ${source_net}":
    chain  => 'FORWARD',
    jump   => 'ACCEPT',
    proto  => 'all',
    source => $source_net,
  }

}
