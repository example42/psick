#
class profile::aws::cli (
  String $ensure                = 'present',
  String $region                = $::profile::aws::region,
  String $aws_access_key_id     = '',
  String $aws_secret_access_key = '',
  String $config_template       = 'profile/aws/credentials.erb',
) {

  include ::profile::python::pip
  tp::install { 'awscli':
    ensure => $ensure,
  }
  ensure_packages('jq')
  package { 'aws-sdk-core':
    ensure   => $ensure,
    provider => 'gem',
  }
  package { 'retries':
    ensure   => $ensure,
    provider => 'gem',
  }
  file { '/root/.aws':
    ensure => directory,
  }
  if $aws_access_key_id != ''
  and $aws_secret_access_key != '' {
    file { '/root/.aws/credentials':
      ensure  => $ensure,
      content => template($config_template),
      mode    => '0400',
    }
  }

  if $region != '' {
    file { '/root/.aws/config':
      ensure  => $ensure,
      content => template('profile/aws/config.erb'),
    }
  }
}
