# Manage a gitlab runner
#
define tools::gitlab::runner (
  String $token,
  String $url,
  String $executor      = 'shell',
  String $extra_options = '',
  String $tag_list      = '',
  String $tls_ca_file   = '',
) {
  $tls_option = $tls_ca_file ? {
    ''      => '',
    default => "--tls-ca-file ${tls_ca_file}",
  }
  $tag_option = $tag_list ? {
    ''      => '',
    default => "--tag-list ${tag_list}",
  }

  $command_options = "--non-interactive --executor ${executor} --name ${title} --url ${url} --registration-token ${token} ${extra_options} ${tag_option} ${tls_option}"
  $saved_options = "${executor} ${title} ${url} ${token} ${tag_option} ${tls_option}"
  exec { "gitlab-runner register ${title}":
    command => "gitlab-runner register ${command_options} && echo ${saved_options} > /etc/gitlab-runner/.registered-${title}",
    unless  => "grep '${saved_options}' /etc/gitlab-runner/.registered-${title}",
    require => Tp::Install['gitlab-runner'],
  }
}
