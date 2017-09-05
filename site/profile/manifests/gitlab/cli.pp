# This class installs and configures via tp the gitlab-cli tool, used to
# compare Puppet catalogs from different sources
#
# @param ensure Define if to install (present), remove (absent) or the version
#   of the gitlab-cli gem
# @param auto_prerequisites Define if to automatically install the prerequisites
#   needed by gitlab-cli
# @param epp The path of the epp template (as used in epp()) to use
#   as content for the gitlab-cli configuration file. Note that this file is not an
#   official file for gitlab-cli.
#   It's used by scripts executed in CI steps involving merge request and accept
#   operations.
#
# @param template The path of the erb template (as used in template() to use
#  as content for gitlab-cli config file. This is alternative to epp.
#
# @param config_hash An open hash of options you can use in your template. Note that
#   this hash is merged with an hash of default options provided in the class
#
class profile::gitlab::cli (
  String           $ensure             = 'present',
  Boolean          $auto_prerequisites = true,
  Optional[String] $epp                = 'profile/gitlab/cli/gitlab-cli.conf.epp',
  Optional[String] $template           = undef,
  Hash             $config_hash        = {},
) {

  $default_hash = {
    project_id => '',
    private_token => '',
    api_endpoint => "https =>//gitlab.${::facts['networking']['domain']}/api/v3",
    httparty_options => '{verify => false}',
    assigned_user => '',
    milestone => '',
    labels => 'automerge',
    add_target_label => false,
    add_source_label => false,
    prefix_target_label => 'TO_',
    prefix_source_label => 'FROM_',
  }
  $options = $default_hash + $config_hash

  ::tp::install { 'gitlab-cli' :
    ensure             => $ensure,
    auto_prerequisites => $auto_prerequisites,
  }
  if $template or $epp {
    $file_content = $template ? {
      undef   => epp($epp),
      default => template($template),
    }
    file { '/etc/gitlab-cli.conf':
      ensure  => $ensure,
      content => $file_content,
    }
  }

}
