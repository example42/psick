# This class manages /etc/psick and relevant files
#
# @param template The path of the erb template (as used in template())
#                           to use for the content of /etc/psick.
#                           If empty the file is not managed.
#
class psick::psick (
  String $template  = '',
  Hash $options     = {},

  Boolean $add_tz_optimisation = true,
) {

  if $template != '' {
    file { '/etc/psick':
      content => template($template),
    }
  }
  file { '/etc/psick.d/tz.sh':
    ensure  => bool2ensure($add_tz_optimisation),
    content => template('psick/psick/tz.sh.erb'),
  }
}
