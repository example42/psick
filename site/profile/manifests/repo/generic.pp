# Generic repo management wrapper class
# Repos to create, besides default ones (when add_defaults = true)
# are looked up via hiera_hash
#
class profile::repo::generic (
  Boolean $add_defaults,
  String $yum_resource,
  String $apt_resource,
  String $zypper_resource,
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
