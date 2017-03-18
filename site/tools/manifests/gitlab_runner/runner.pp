# Manage a gitlab runner
#
define tools::gitlab_runner::runner (
  String $token,
  String $url,
  String $executor      = 'shell',
  String $extra_options = '',
) {
  $command_options = "--non-interactive --executor ${executor} --name ${title} --url ${url} --registration-token ${token} ${extra_options}"
  exec { "gitlab-runner register ${title}":
    command => "gitlab-runner register ${command_options} && touch /etc/gitlab-runner/.registered-${title}",
    creates => "/etc/gitlab-runner/.registered-${title}",
    require => Tp::Install['gitlab-runner'],
  }
}
