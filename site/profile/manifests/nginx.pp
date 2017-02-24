#
class profile::nginx (
  Enum['present','absent'] $ensure                     = 'present',

  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = 'profile/nginx/nginx.conf.erb',
) {

  tp::install('nginx', { ensure => $ensure })
  $nginx_options = {
    'worker_processes'   => '12',
    'worker_connections' => '512',
  }
  tp::conf { 'nginx':
    template     => $config_file_template,
    options_hash => $nginx_options,
  }

}
