# This class manages /etc/motd and /etc/issue files.
#
# @param motd_file_ensure If to create or remove /etc/motd
# @param motd_file_template The path of the erb template (as used in template())
#                           to use for the content of /etc/motd.
#                           If empty the file is not managed.
# @param motd_file_extratext A custom extra string to add at the end of the
#                            default template of /etc/motd
# @param issue_file_ensure If to create or remove /etc/issue
# @param issue_file_template The path of the erb template (as used in template())
#                            to use for the content of /etc/issue
#                            If empty the file is not managed.
# @param issue_file_extratext A custom extra string to add at the end of the
#                             default template of /etc/issue
#
class psick::motd (
  String $motd_file_ensure    = 'present',
  String $motd_file_template  = 'psick/motd/motd.erb',
  String $motd_extratext      = '',

  String $issue_file_ensure   = 'present',
  String $issue_file_template = 'psick/motd/issue.erb',
  String $issue_extratext     = '',
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
