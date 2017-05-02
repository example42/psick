# Class profile::time
# This class manages time on different OS in various ways:
# 
# @param servers Arrays of ntp servers to set
# @param method How to set time via ntp.
#    chrony - use Chrony. Requires aboe/chrony module
#    ntp - use official Puppet Ntp module. Requires puppetlabs/ntp
#    ntpdate - Schedule ntp updates via profile::time::ntpdate
#
# On Windows the profile::windows::time class is used to set ntp.
#
class profile::time (
  Array $servers,
  Optional[String] $timezone,
  Enum['chrony','ntpdate','ntp',''] $method,
) {

  if $timezone {
    include ::profile::timezone
  }

  if $::kernel == 'Linux' and $method == 'chrony' {
    class { '::chrony':
      servers => $servers,
    }
  }

  if $::kernel == 'Linux' and $method == 'ntpdate' {
    include ::profile::time::ntpdate
  }

  if $::kernel != 'Windows' and $method == 'ntp' {
    class { '::ntp':
      servers => $servers,
    }
  }

  if $::osfamily == 'Windows' {
    include ::profile::time::windows
  }

}
