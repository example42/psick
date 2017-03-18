# This class installs and configures via tp the gitlab-cli tool, used to
# compare Puppet catalogs from different sources
#
# @param ensure Define if to install (present), remote (absent) or the version
#               of the gitlab-cli gem
# @param auto_prerequisites Define id to automatically install the prerequisites
#                           needed by gitlab-cli
# @param template The path of the erb template (as used in template()) to use
#                 as content for the gitlab-cli configuration file. Note that
#                 this file is not a real official file for gitlab-cli, but just
#                 a fie where are exported the needed environment variables.
# @param options An open hash of options you can use in your template. Note that
#                this hash is merged with an hash of default options provided in
#                the class
#
class profile::gitlab::cli (
  String           $ensure             = 'present',
  Boolean          $auto_prerequisites = true,
  Optional[String] $template           = 'profile/gitlab/cli/gitlab-cli.conf.erb',
  Hash             $extra_options      = { },

  String           $private_token      = '',
  String           $api_endpoint       = "https://gitlab.${::domain}/api/v3",
  String           $project_id         = '1',

) {

  $options_default = {
    'GITLAB_API_ENDPOINT' => $api_endpoint,
    'GITLAB_API_PRIVATE_TOKEN' => $private_token,
    'GITLAB_API_HTTPARTY_OPTIONS' => '{verify: false}', # Need for self signed https
    'GITLAB_API_PROJECT_ID' => $project_id,
  }
  $options = $options_default + $extra_options
  ::tp::install { 'gitlab-cli' :
    ensure             => $ensure,
    auto_prerequisites => $auto_prerequisites,
  }

  if $template {
    file { '/etc/gitlab-cli.conf':
      ensure  => $ensure,
      content => template($template),
    }
  }

}
