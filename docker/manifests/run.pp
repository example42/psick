#$apps=inline_template("<%= scope.lookupvar('docker_apps').split(',') %>")
#notify { $apps : }

#$apps.each |$app| {
  docker::run { $::docker_app:
    ensure           => present,
    username         => $::docker_username,
    repository_tag   => "${::docker_os}-${::docker_osversion}",
    exec_environment => [ "DOCKER_CONFIG=${::docker_config}" ],
    run_options      => '--publish-all',
  }

  #}
