#
class psick::nginx (
  Enum['present','absent'] $ensure       = 'present',

  Optional[String[1]] $config_dir_source = undef,
  Optional[String] $config_file_template = undef,
) {

  tp_install('nginx', { ensure => $ensure })
  $nginx_options = {
    'worker_processes'   => '12',
    'worker_connections' => '512',
  }
  if $config_file_template {
    tp::conf { 'nginx':
      template     => $config_file_template,
      options_hash => $nginx_options,
    }
  }

}
