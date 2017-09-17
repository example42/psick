# Basic users management
# This psick manages basic user accounts providing parameter to manage the
# root user and other ones which accept hashes of resources to be passed to
# alternative defines used to create users. These hashes are looked up via
# a merge lookup with -- as knockout prefix.
#
# @param root_pw The root password. If set the root user resource is managed
#   here. Use root_params to customise other attributes of the user type for
#   root.
# @param root_params An hash of valid arguments of the user type. If this or
#   root_pw is set, the root user is managed by this class.
# @param users_hash An Hash passed to create_resources with Puppet user type
# @param managed_users_hash An Hash passed to create_resources with the define
#   tools::users::managed from this control-repo
# @param accounts_users_hash An Hash passed to create_resources with the define
#   accounts::user from puppetlabs-accounts module
# @param delete_unmanaged If true all non system users not managed by Puppet
#    are automatically deleted.
class psick::users::static (
  Optional[String[1]] $root_pw = undef,
  Hash $root_params            = {},
  Hash $users_hash             = {},
  Hash $managed_users_hash     = {},
  Hash $accounts_users_hash    = {},
  Boolean $delete_unmanaged    = false,
) {

  if $root_pw or $root_params != {}  {
    user { 'root':
      password => $root_pw,
      *        => $root_params,
    }
  }
  if $users_hash != {} {
    create_resources('user',$users_hash)
  }
  if $managed_users_hash != {} {
    create_resources('tools::user::managed',$managed_users_hash)
  }
  if $accounts_users_hash != {} {
    create_resources('accounts::user',$accounts_users_hash)
  }
  if $delete_unmanaged {
    resources { 'user':
      purge              => true,
      unless_system_user => true,
    }
  }
}
