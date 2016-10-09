# This class manages sysctl
#
class profile::sysctl {
  $my_sysctl_defaults = {}
  $my_sysctl_settings = hiera_hash('profile::sysctl::settings', {})
  if $my_sysctl_settings != {} {
    $my_sysctl_settings.each |$k,$v| {
      ::tools::sysctl { $k:
        value => $v,
      }
    }
  }
}
