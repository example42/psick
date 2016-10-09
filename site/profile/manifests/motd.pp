# Manages /etc/motd and /etc/issue
#
class profile::motd (
  String $motd_file_ensure    = 'present',
  String $motd_file_template  = '',

  String $issue_file_ensure    = 'present',
  String $issue_file_template = '',
) {

  if $motd_file_template != '' {
    file { '/etc/motd':
      ensure  => $motd_file_ensure,
      content => template($motd_file_template),
    }
  }
  if $issue_file_template != '' {
    file { '/etc/issue':
      ensure  => $issue_file_ensure,
      content => template($issue_file_template),
    }
  }
}
