# Basic sudo management
# This profile uses saz-sudo module
#
class profile::sudo::sudoers (
  String $admins_group   = '',
  String $admins_content = 'ALL=(ALL) NOPASSWD: ALL',
  Boolean $purge_file    = false,
  Boolean $purge_dir     = false,
) {

  class { '::sudo':
    config_file_replace => $purge_file,
    purge               => $purge_dir,
  }

  if $admins_group != '' {
    ::sudo::conf { $admins_group:
      priority => 10,
      content  => "%${admins_group} ${admins_content}",
    }
  }
}
