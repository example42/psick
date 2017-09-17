# This class installs and configures multipath (only on physical servers)
#
# @param config_file_template The path of the erb template to use for the
#                             content of /etc/multipath.conf.
#                             If empty the file is not managed.
# @param user_friendly_names Defines the content of the user_friendly_names
#                            entry in multipath.conf
#
class psick::multipath (
  String $config_file_template = 'psick/multipath/multipath.conf.erb',
  String $user_friendly_names  = 'yes',
) {

  if $config_file_template != '' and $::virtual == 'physical' {
    tp::conf { 'multipath':
      content => template($config_file_template),
    }
    tp::install { 'multipath': }
  }

}
