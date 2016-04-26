class profile::docker::build (
  Hash                    $apps                = {},

  String[1]               $ensure              = 'present',

  Variant[Undef,String]   $template            = 'tp_docker/Dockerfile.erb',
  String[1]               $workdir             = '/var/tmp',

  String[1]               $username            = 'example42',

  String[1]               $default_os          = downcase($::operatingsystem),
  String[1]               $default_osversion   = $::operatingsystemmajrelease,

  Variant[Undef,String]   $maintainer          = undef,
  String                  $from                = '',

  Variant[Undef,String]   $repository_tag      = 'latest',

  Variant[Undef,Array]    $exec_environment    = [],
  Variant[Boolean,Pattern[/on_failure/]] $exec_logoutput = 'on_failure',

  String                  $build_options       = '',
  Pattern[/command|supervisor/] $command_mode  = 'supervisor',

  Boolean                 $mount_data_dir      = true,
  Boolean                 $mount_log_dir       = true,

  Hash                    $settings_hash       = {},

  String[1]               $data_module         = 'tinydata',

) {

  tp::install { 'docker-engine': }
  # tp_install('docker-engine')

  tp::dir { 'docker-engine':
    source  => 'https://github.com/example42/tp-dockerfiles',
    path    => '/etc/tp-dockerfiles',
    vcsrepo => 'git',
  }

  $apps.each |$app,$opts| {

    tp_docker::build { $app:
      ensure           => pick_default($opts['ensure'],$ensure),
      template         => pick_default($opts['template'],$template),
      workdir          => pick_default($opts['workdir'],$workdir),
      username         => pick_default($opts['username'],$username),
      os               => pick_default($opts['os'],$default_os),
      osversion        => pick_default($opts['osversion'],$default_osversion),
      maintainer       => pick_default($opts['maintainer'],$maintainer),
      from             => pick_default($opts['from'],$from),
      repository       => pick_default($opts['repository'],$app),
      repository_tag   => pick_default($opts['repository_tag'],$repository_tag),
      exec_environment => pick_default($opts['exec_environment'],$exec_environment),
      exec_logoutput   => pick_default($opts['exec_logoutput'],$exec_logoutput),
      build_options    => pick_default($opts['build_options'],$build_options),
      command_mode     => pick_default($opts['command_mode'],$command_mode),
      mount_data_dir   => pick_default($opts['mount_data_dir'],$mount_data_dir),
      mount_log_dir    => pick_default($opts['mount_log_dir'],$mount_log_dir),
      settings_hash    => $settings_hash,
      data_module      => $data_module,
      require          => Tp::Install['docker-engine'],
    }
  }

}
