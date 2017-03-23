# Define tools::profile::script
# Derived from https://github.com/example42/puppet-profile
# This define creates a single script in /etc/profile.d
#
define tools::profile::script (
  Enum['present','absent'] $ensure = 'present',
  Boolean $autoexec                = false,
  String $source                   = '',
  String $content                  = '',
  String $template                 = '',
  String $config_dir               = '/etc/profile.d',
  String $owner                    = 'root',
  String $group                    = 'root',
  String $mode                     = '0755' ) {

  $safe_name = regsubst($name, '/', '_', 'G')
  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }

  if !empty($content) {
    $manage_file_content = $content
  } elsif !empty($template) {
    $manage_file_content = tools::template($template)
  }

  file { "profile_${safe_name}":
    ensure  => $ensure,
    path    => "${config_dir}/${safe_name}.sh",
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => $manage_file_content,
    source  => $manage_file_source,
  }

  if $autoexec and $ensure == 'present' {
    exec { "profile_${safe_name}":
      command     => "sh ${config_dir}/${safe_name}.sh",
      refreshonly => true,
      subscribe   => File[ "profile_${safe_name}" ],
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    }
  }
}
