# Manage a gitlab project
# This define needs the class profile::gitlab::cli
# and is declared in the class rofile::gitlab
# Note: Currently this define does not manage CHANGES
# in the managed resource.
#
define tools::gitlab::project (
  String  $namespace      = '',
  Optional[Integer] $namespace_id = undef,
  String  $owner          = '',
  Optional[Integer] $owner_id = undef,
  String  $description    = $title,
  String  $default_branch = 'master',
  Boolean $public         = true,
  Hash    $options        = {},

  Array $exec_environment = [ "GITLAB_API_ENDPOINT=${::profile::gitlab::cli::api_endpoint}",
                              "GITLAB_API_PRIVATE_TOKEN=${::profile::gitlab::cli::private_token}",
                              "GITLAB_API_HTTPARTY_OPTIONS='{verify: false}'" ],
                              # for self signed https certs
) {

  $real_namespace_id=pick($namespace_id,gitlab_get_id('namespace',$namespace),undef)
  $real_owner_id=pick($owner_id,gitlab_get_id('user',$owner),undef)
  $public_id = $public ? {
    0 => true,
    1 => false,
  }

  $default_options = {
    namespace_id => $real_namespace_id,
    user_id => $real_owner_id,
    description => $description,
    public => $public_id,
    default_branch => $default_branch,
  }
  $command_options = $default_options + $options

  exec { "gitlab create_project ${title}":
    command => "gitlab create_project ${title} ${command_options}",
    unless  => "gitlab projects --only=name | grep ${title}",
    require => Class['profile::gitlab::cli'],
  }
}
