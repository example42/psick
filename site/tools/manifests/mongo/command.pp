# Define: tools::mongo::command
#
define tools::mongo::command (
  $template,
  $options     = {},
  $password    = undef,
  $roles       = '[]',
  $db_host     = '127.0.0.1',
  $db_port     = '27017',
  $db_name     = '',
  $cmd_options = '',
  $js_dir      = '/root/mongo-commands',
  $ensure      = 'present',
  $run_command = true,
) {

  if (!defined(File[$js_dir])) {
    file {$js_dir:
      ensure => directory,
      path   => $js_dir,
      owner  => 'root',
      group  => 'root',
      mode   => '0700',
    }
  }

  $mongodb_script_user = "mongo_${name}.js"
  $db_name_suffix = $db_name ? {
    ''      => '',
    default => "/${db_name}",
  }
  file { $mongodb_script_user:
    ensure  => present,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    path    => "${js_dir}/${mongodb_script_user}",
    content => template($template),
  }

  if $run_command {
    exec { "mongo_${name}":
      command     => "mongo ${cmd_options} ${db_host}:${db_port}${db_name_suffix} ${js_dir}/${mongodb_script_user}",
      subscribe   => File[$mongodb_script_user],
      path        => [ '/usr/bin' , '/usr/sbin' ],
      refreshonly => true,
    }
  }

}
