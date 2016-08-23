# Basic users management
#
class profile::users::static (
  Optional[String[1]] $rootpw  = undef,
  Hash $users                  = {},
  Hash $managed_users          = {},
  Boolean $delete_unmanaged    = false,
) {

  if $rootpw {
    user { 'root':
      password => $rootpw,
    }
  }
  if $users != {} {
    create_resources('user',$users)
  }
  if $managed_users != {} {
    create_resources('profile::users::managed',$managed_users)
  }
  if $delete_unmanaged {
    resources { 'user':
      purge              => true,
      unless_system_user => true,
    }
  }
}
