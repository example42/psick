class profile::aws::cli (
  String $ensure                = 'present',
  String $aws_access_key_id     = '',
  String $aws_secret_access_key = '',
) {

  include profile::python::pip
  tp::install { 'awscli':
    ensure => $ensure,
  }
  package { 'aws-sdk-core':
    ensure   => $ensure,
    provider => 'gem',
  }
  package { 'retries':
    ensure   => $ensure,
    provider => 'gem',
  }
  if $aws_access_key_id != ''
  and $aws_secret_access_key != '' {
    file { '/root/.aws':
      ensure => directory,
    }
    file { '/root/.aws/credentials':
      ensure  => $ensure,
      content => template('profile/aws/credentials'),
      mode    => '0400',
    }
  }
}
