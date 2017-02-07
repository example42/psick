# = Define: tools::nfs::export
# Manages nfs exports either via concat on /etc/exports
# or with files in /etc/exports.d/ (if $use_exportsd is set to true)
#
define tools::nfs::export (
  Enum[present,absent] $ensure  = 'present',

  String $share                 = '/srv/nfs',

  String $guest                 = '127.0.0.1',
  String $options               = '',

  String $content               = '',

  Boolean $use_exportsd         = false,
) {

  if $options != '' {
    $auto_content = "${share} ${guest}(${options})\n"
  } else {
    $auto_content = "${share} ${guest}\n"
  }
  $real_content = $content ? {
    ''      => $auto_content,
    default => $content,
  }
  $safe_name = regsubst($name, '/', '_', 'G')

  if $use_exportsd {
    file { "/etc/exports.d/${safe_name}.export":
      content => $real_content,
      notify  => Exec['exportfs -a'],
    }
  } else {
    if !defined(Concat['/etc/exports']) {
      concat { '/etc/exports':
        ensure => $ensure,
        mode   => '0644',
        owner  => 'root',
        group  => 'root',
        notify => Exec['exportfs -a'],
      }
    }
    concat::fragment { "/etc/exports_${title}":
      target  => '/etc/exports',
      content => $real_content,
      notify  => Exec['exportfs -a'],
    }
  }

  if !defined(Exec['exportfs -a']) {
    exec { 'exportfs -a':
      refreshonly => true,
    }
  }

  if !defined(Exec["mkdir -p ${share}"]) {
    exec { "mkdir -p ${share}":
      creates => $share,
    }
  }

}
