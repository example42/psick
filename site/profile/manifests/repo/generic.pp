# Generic repo management wrapper class
# Repos to create, besides default ones (when add_defaults = true)
# are looked up via hiera_hash
#
class profile::repo::generic (
  Boolean $add_defaults   = false,
  String $yum_resource    = 'yumrepo',     # Native resource type
  String $apt_resource    = 'apt::source', # From puppetlabs-apt
  String $zypper_resource = 'zypprepo',    # From darin-zypprepo
) {

  # Default repos
  if $add_defaults {
    case $::osfamily {
      'RedHat': {
        tp::install { 'epel': auto_prerequisites => true }
      }
      'Debian': {
      }
      'Suse': {
      }
      default: {
      }
    }
  }

  # User repos via hiera
  $yum_repos = lookup('yum_repos', Hash, 'merge', {} )
  $apt_repos = lookup('apt_repos', Hash, 'merge', {} )
  $zypper_repos = lookup('zypper_repos', Hash, 'merge', {} )

  if $yum_repos != {} {
    create_resources($yum_resource, $yum_repos)
  }
  if $apt_repos != {} {
    create_resources($apt_resource, $apt_repos)
  }
  if $yum_repos != {} {
    create_resources($zypper_resource, $yum_repos)
  }

}
