# @class jenkins
#
class role::jenkins_slave (

  Variant[Boolean,String]    $ensure     = 'present',
  Enum['psick']              $module     = 'psick',

  Hash                       $plugins    = {},

  Hash                       $init_options  = {},

  Optional[String] $ssh_private_key_content = undef,
  Optional[String] $ssh_public_key_content  = undef,
  Optional[String] $ssh_private_key_source  = undef,
  Optional[String] $ssh_public_key_source   = undef,

  Boolean $ssh_keys_generate                = false,
  String $home_dir                          = 'c:\\Users\\Administrator',

  Optional[String] $scm_sync_repository_url  = undef,
  Optional[String] $scm_sync_repository_host = undef,

  Boolean $disable_setup_wizard              = false,
) {

  $java_args_extra = $disable_setup_wizard ? {
    true  => '-Djenkins.install.runSetupWizard=false',
    false => '',
  }

  $default_init_options = {
    'NAME'           => 'jenkins',
    'JAVA'           => '/usr/bin/java',
    'JAVA_ARGS'      => "-Djava.awt.headless=true ${java_args_extra}",
    'PIDFILE'        => '/var/run/$NAME/$NAME.pid',
    'JENKINS_USER'   => '$NAME',
    'JENKINS_GROUP'  => '$NAME',
    'JENKINS_WAR'    => '/usr/share/$NAME/$NAME.war',
    'JENKINS_HOME'   => '/var/lib/$NAME',
    'RUN_STANDALONE' => 'true', # lint:ignore:quoted_booleans
    'JENKINS_LOG'    => '/var/log/$NAME/$NAME.log',
    'MAXOPENFILES'   => '8192',
    'HTTP_PORT'      => '8080',
    'PREFIX'         => '/$NAME',
    'JENKINS_ARGS'   => '--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT',
  }
  $all_init_options = $default_init_options + $init_options

  # Installation management

  # SSH keys management
  if $ssh_private_key_content
  or $ssh_public_key_content
  or $ssh_private_key_source
  or $ssh_public_key_source
  or $scm_sync_repository_host {
    $dir_ensure = ::tp::ensure2dir($ensure)
    file { "${home_dir}/.ssh" :
      ensure  => $dir_ensure,
    }
  }

  if $ssh_private_key_content or $ssh_private_key_source {
    file { "${home_dir}/.ssh/id_rsa" :
      ensure  => $ensure,
      content => $ssh_private_key_content,
      source  => $ssh_private_key_source,
    }
  }

  if $ssh_public_key_content or $ssh_public_key_source {
    file { "${home_dir}/.ssh/id_rsa.pub" :
      ensure  => $ensure,
      content => $ssh_public_key_content,
      source  => $ssh_public_key_source,
    }
  }

  if $scm_sync_repository_url {
    include ::psick::jenkins::scm_sync
  }

  if $scm_sync_repository_host {
    psick::openssh::config { 'jenkins':
      path         => "${home_dir}/.ssh/config",
      before       => Service['jenkins'],
      options_hash => {
        "Host ${scm_sync_repository_host}" => {
          'StrictHostKeyChecking' => 'no',
          'UserKnownHostsFile'    => '/dev/null',
        }
      }
    }
  }

}
