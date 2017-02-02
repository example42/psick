# Class profile::time::ntp
# This class uses aboe/chrony and puppetlabs/ntp modules to manage NTP on Linux
# and Unix.
# Usage via Hiera:
# profile::time::ntp::servers:
#   - my.ntp.com
#   - 1.2.3.4
#
class profile::time::ntp (
  Array                 $servers         = [ '0.de.pool.ntp.org' , '1.de.pool.ntp.org' ],
  Variant[Undef,Array]  $chrony_keys     = undef,
  Variant[Undef,String] $chrony_password = undef,
) {

  if $::osfamily == 'RedHat' and $::operatingsystemmajrelease == '7' {
    class { '::chrony':
      servers         => $servers,
      keys            => $chrony_keys,
      chrony_password => $chrony_password,
    }
  } else {
    class { '::ntp':
      servers => $servers,
    }
  }

}
