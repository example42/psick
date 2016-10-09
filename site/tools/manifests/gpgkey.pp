#
define tools::gpgkey (
  String $source                    = '',
  String $rpm_gpg_dir_path          = '/etc/pki/rpm-gpg',
  String $checksum                  = '',
  Pattern[/present|absent/] $ensure = present,
) {

  if !defined(File[$rpm_gpg_dir_path]) {
    file { $rpm_gpg_dir_path:
      ensure => directory,
    }
  }

  if $source != '' {
    file { $title:
      ensure => $ensure,
      path   => "${rpm_gpg_dir_path}/${title}",
      source => "${source}",
    }
  }

  $short_title = regsubst($title,'RPM-GPG-KEY-','')
  gpg_key { $short_title:
    path   => "${rpm_gpg_dir_path}/${title}",
  }

  if $checksum != '' {
    if $ensure == 'present' {
      exec { "rpm --import /etc/pki/rpm-gpg/${title}":
        unless => "rpm -q gpg-pubkey --qf '%{version}' | grep -i ${checksum}",
      }
    } else {
      exec { "rpm -e gpg-pubkey-${checksum}-*":
        onlyif => "rpm -qi  gpg-pubkey-${checksum}-*",
      }
    }
  }

}
