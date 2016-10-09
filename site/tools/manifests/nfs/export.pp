# = Define: tools::nfs::export 
# Based on https://github.com/camptocamp/puppet-nfs/blob/master/manifests/export.pp
#
define tools::nfs::export (
  Enum[present,absent] $ensure  = 'present',

  String $share                 = '/srv/nfs',

  String $guest                 = '127.0.0.1',
  String $options               = '',

  String $content               = '',

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

  if !defined(Concat['/etc/exports']) {
    concat { '/etc/exports':
      owner => root,
      group => root,
      mode  => '0644',
    }
  }

  concat::fragment { "${name}-${real_content}":
    content => $real_content,
    target  => '/etc/exports',
    notify  => Exec['exportfs -a'],
  }

  exec { 'exportfs -a':
    refreshonly => true,
  }

  if !defined(Exec["mkdir -p ${share}"]) {
    exec { "mkdir -p ${share}":
      creates => $share,
    }
  }

}
