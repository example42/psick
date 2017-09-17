# Generic class to manage network hardening.
#
# @param modprobe_template Path of the template (as used by template()) to
#                          manage '/etc/modprobe.d/hardening.conf (Only on RHEL)
# @param netconfig_template Path of the template (as used by template()) to
#                           manage '/etc/netconfig (Only on RHEL)
# @param blacklist_template Path of the template (as used by template()) to
#                           manage '/etc/modprobe.d/blacklist-nouveau.conf (Only on RHEL)
# @param services_template Path of the template (as used by template()) to
#                          manage '/etc/services (Only on RHEL)
# @param remove_ftp_user Remove or leave the local ftp user
#
class psick::hardening::network (
  String $modprobe_template  = '',
  String $netconfig_template = '',
  String $blacklist_template = '',
  String $services_template  = '',
) {

  if $::osfamily == 'RedHat' {
    if $modprobe_template != '' {
      file { '/etc/modprobe.d/hardening.conf':
        ensure  => file,
        content => template($modprobe_template),
      }
    }
    if $blacklist_template != '' {
      file { '/etc/modprobe.d/blacklist-nouveau.conf':
        ensure  => file,
        content => template($blacklist_template),
      }
    }
    if $netconfig_template != '' {
      file { '/etc/netconfig':
        ensure  => file,
        content => template($netconfig_template),
      }
    }
  }

  if $services_template != '' {
    file { '/etc/services':
      ensure  => file,
      content => template($services_template),
    }
  }

}
