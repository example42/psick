#
define tools::sysctl (
  Any    $value,
  String $key = $title,
) {

  sysctl { $key :
    val    => $value,
    before => Exec["exec_sysctl_${key}"],
  }

  $command = $::kernel ? {
    'openbsd' => "sysctl ${key}=\"${value}\"",
    default   => "sysctl -w ${key}=\"${value}\"",
  }

  $unless = $::kernel ? {
    'openbsd' => "sysctl ${key} | grep -q '=${value}\$'",
    default   => "sysctl ${key} | grep -q ' = ${value}'",
  }

  exec { "exec_sysctl_${key}" :
    command => $command,
    unless  => $unless,
    require => Sysctl[$key],
    path    => '/sbin:/bin:/usr/sbin:/usr/bin',
  }
}
