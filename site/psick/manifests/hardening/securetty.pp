# == Class: os_hardening::securetty
#
# Configures securetty.
#
# @param root_ttys An array of ttys from which is allowed root access
# @param securetty_template The erb template path, as used in template(), to
#                           use to manage the content of /etc/securetty
#
class psick::hardening::securetty (
  Array $root_ttys           = ['console','tty1','tty2','tty3','tty4','tty5','tty6'],
  String $securetty_template = 'psick/hardening/securetty/securetty.erb',
){
  $ttys = join( $root_ttys, "\n")
  file { '/etc/securetty':
    ensure  => file,
    content => template( $securetty_template ),
    owner   => root,
    group   => root,
    mode    => '0400',
  }
}
