# Generic repo management wrapper class
# Repos to create, besides default ones (when add_defaults = true)
# are looked up via hiera_hash
#
class profile::repo::generic (
  Boolean $add_defaults = false,
  String $yum_resource = 'yumrepo',     # As native resource type
  String $apt_resource = 'apt::source', # As in puppetlabs-apt
  String $zypper_resource = 'zypprepo', # As in darin-zypprepo
) {

  # Default repos
  if $add_defaults {
    case $::osfamily {
      'RedHat': {
        tp::repo { 'epel': }
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
  $yum_repos = hiera_hash('yum_repos', {})
  $apt_repos = hiera_hash('apt_repos', {})
  $zypper_repos = hiera_hash('zypper_repos', {})

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
