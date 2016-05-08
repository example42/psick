# 
#$apps=inline_template("<%= scope.lookupvar('docker_apps').split(",") %>")
#$apps.each |$app| {

  docker::build { $::docker_app:
    ensure           => present,
    workdir          => $::docker_workdir,
    username         => $::docker_username,
    os               => $::docker_os,
    osversion        => $::docker_osversion,
    maintainer       => $::docker_maintainer,
    repository_tag   => "${::docker_os}-${::docker_osversion}",
    #   from         => "example42/${::docker_os}/supervisor",
    exec_environment => [ "DOCKER_CONFIG=${::docker_config}" ],
    exec_logoutput   => true,
    # build_options  => '--no-cache',
    command_mode     => 'supervisor',
  }

  #}
