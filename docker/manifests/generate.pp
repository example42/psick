# Define here the applications (based on Tiny Data) for which
# you want to build and eventually push images
$apps = [ 'puppet-agent' ]

# 
$apps.each |$app| {

  docker::dockerize { $app:
    ensure           => present,
    workdir          => $::docker_workdir,
    username         => $::docker_username,
    os               => $::docker_os,
    osversion        => $::docker_osversion,
    maintainer       => $::docker_maintainer,
    #   from         => "example42/${::docker_os}/supervisor",
    run              => false,
    build            => true,
    #   push             => true,
    exec_environment => [ "DOCKER_CONFIG=${::docker_config}" ],
    # build_options  => '--no-cache',
    command_mode     => 'supervisor',
  }

}
