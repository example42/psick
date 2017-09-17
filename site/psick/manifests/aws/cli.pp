#
class psick::aws::cli (
  String $ensure                = 'present',
  String $region                = $::psick::aws::region,
  String $aws_access_key_id     = '',
  String $aws_secret_access_key = '',
  String $config_template       = 'psick/aws/credentials.erb',
  Array $install_gems = [ 'aws-sdk-core' , 'retries' ],
  Boolean $install_system_gems     = true,
  Boolean $install_puppet_gems     = true,
) {

  include ::psick::python::pip
  include ::psick::ruby

  tp::install { 'awscli':
    ensure => $ensure,
  }
  ensure_packages('jq')

  $install_gems.each | $gem | {
    if $install_system_gems {
      package { $gem:
        ensure   => $ensure,
        provider => 'gem',
        require  => Class['psick::ruby'],
      }
    }
    if $install_puppet_gems {
      package { "puppet_${gem}":
        ensure   => $ensure,
        name     => $gem,
        provider => 'puppet_gem',
        require  => Class['psick::ruby'],
      }
    }
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
      content => template('psick/aws/config.erb'),
    }
  }
}
