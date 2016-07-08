#
define profile::aws::script (
  String $ensure = 'present',
  String $template,
  Boolean $autorun = true,
  String $destination_dir = '/var/tmp',
  Variant[Undef,String] $region = undef,
  String $command = '',
) {

  include ::profile::aws

  $script_path = "${destination_dir}/${title}"
  $exec_command = $command ? {
    # ''      => "${script_path} || rm ${script_path}",
    ''      => "${script_path}",
    default => $command,
  }

  file { $script_path:
    ensure  => $ensure,
    path    => $script_path,
    mode    => '0750',
    content => template($template),
  }

  if $autorun {
    exec { "aws script ${title}":
      command     => $exec_command,
      refreshonly => true,
      logoutput   => true,
      subscribe   => File[$script_path],
    }
  }

}
