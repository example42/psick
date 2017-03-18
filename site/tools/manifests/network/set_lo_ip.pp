# write helperfile - caution:
# needs to be included in masterfile like
# /etc/network/interfaces - section interface
# iface lo inet loopback
#	up /etc/network/interfaces_lo add
#	down /etc/network/interfaces_lo del
# used in tools:lb:balance
define tools::network::set_lo_ip (
  String $interfaces_path = '/etc/network/interfaces_lo',
) {

  case $::osfamily {
    'Debian': {
      if !defined(Concat[$interfaces_path]) {
        concat { $interfaces_path:
          mode  => '0755',
          owner => 'root',
          group => 'root',
        }
      }
      concat::fragment { "set_lo_ip_${title}":
        target  => $interfaces_path,
        content => "ip addr \$1 ${title}/32 dev lo",
        order   => '02',
      }
    }
    default: {}
  }
}
