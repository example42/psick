# Manage a gitlab group
# This define needs the class profile::gitlab::cli
# and is declared in the class rofile::gitlab
# Note: Currently this define does not manage CHANGES
# in the managed resource.
#
define tools::gitlab::group (
  String  $path           = $title,
  String  $description    = $title,
  Hash    $options        = {},

  Array $exec_environment = [ "GITLAB_API_ENDPOINT=${::profile::gitlab::cli::api_endpoint}",
                              "GITLAB_API_PRIVATE_TOKEN=${::profile::gitlab::cli::private_token}",
                              "GITLAB_API_HTTPARTY_OPTIONS='{verify: false}'" ],
                              # for self signed https certs
) {

  $default_options = {
    description => $description,
  }
  $command_options = $default_options + $options

  exec { "gitlab create_group ${title}":
    command => "gitlab create_group '${title}' '${path}' \"${command_options}\"",
    unless  => "gitlab groups --only=name | grep ${title}",
    require => Class['profile::gitlab::cli'],
  }
}
