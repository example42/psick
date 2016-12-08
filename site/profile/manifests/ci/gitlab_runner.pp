#
class profile::ci::gitlab_runner (
  String                $ensure      = 'present',
  Boolean               $auto_prerequisites = true,
  Boolean               $auto_register = true,
  Optional[String]      $template    = 'profile/ci/gitlab_runner/config.toml.erb',
  Hash                  $options     = { },
  String                $executor    = 'shell',
  Optional[String]      $token       = undef,
  Optional[String]      $url         = undef,
  String                $runner_name = $::hostname,
) {

  $options_default = {
    'executor'    => $executor,
    'runner_name' => $runner_name,
    'url'         => $url,
    'token'       => $token,
  }
  $gitlab_runner_options = $options_default + $options
  ::tp::install { 'gitlab-runner' :
    ensure             => $ensure,
    auto_prerequisites => true,
  }

  ::tp::conf { 'gitlab-runner':
    ensure       => $ensure,
    template     => $template,
    options_hash => $gitlab_runner_options,
  }

  if $auto_register {
    $command_options = "--non-interactive --executor ${executor} --name ${runner_name} --url ${url} --registration-token ${token}"
    exec { 'gitlab-runner register':
      command     => "gitlab-runner register ${command_options}",
      #     onlyif  => "bash '! grep ${token} /etc/gitlab-runner/config.toml'",
      refreshonly => true,
      subscribe   => Tp::Conf['gitlab-runner'],
    }
  }
}

