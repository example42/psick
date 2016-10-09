# Define tools::profile::script
# Derived from https://github.com/example42/puppet-profile
# This define creates a single script in /etc/profile.d
#
define tools::profile::script (
  Integer $priority  = '10',
  Boolean $autoexec  = false,
  String $source     = '',
  String $content    = '',
  String $template   = '',
  String $epp        = '',
  String $config_dir = '/etc/profile.d',
  String $owner      = 'root',
  String $group      = 'root',
  String $mode       = '0755' ) {

  $safe_name = regsubst($name, '/', '_', 'G')
  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }
  $manage_file_content = tp_content($content, $template, $epp)

  file { "profile_${priority}_${safe_name}":
    path    => "${config_dir}/${priority}-${safe_name}.sh",
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => $manage_file_content,
    source  => $manage_file_source,
  }

  if $autoexec {
    exec { "profile_${priority}_${safe_name}":
      command     => "sh ${config_dir}/${priority}-${safe_name}.sh",
      refreshonly => true,
      subscribe   => File[ "profile_${priority}_${safe_name}" ],
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    }
  }
}
