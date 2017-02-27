# This class manages /etc/profile and relevant files
#
# @param template The path of the erb template (as used in template())
#                           to use for the content of /etc/profile.
#                           If empty the file is not managed.
#
class profile::profile (
  String $template  = '',
  Hash $options     = {},

  Boolean $add_tz_optimisation = true,
  Boolean $add_proxy_settings  = true,
) {

  if $template != '' {
    file { '/etc/profile':
      content => template($template),
    }
  }
  file { '/etc/profile.d/tz.sh':
    ensure  => bool2ensure($add_tz_optimisation),
    content => template('profile/profile/tz.sh.erb'),
  }
  file { '/etc/profile.d/proxy.sh':
    ensure  => bool2ensure($add_proxy_settings),
    content => template('profile/profile/proxy.sh.erb'),
  }
}
