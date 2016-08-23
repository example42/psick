# Basic sudo management
# This profile uses saz-sudo module
#
class profile::sudo::sudoers (
  Optional[String[1]] $admins_group = undef,
  Boolean $config_file_replace      = false,
  Boolean $purge                    = false,
) {

  class { '::sudo':
    config_file_replace => $config_file_replace,
    purge               => $purge,
  }

  if $admins_group {
    ::sudo::conf { $admins_group:
      priority => 10,
      content  => "%${admins_group} ALL=(ALL) NOPASSWD: ALL",
    }
  }
}
