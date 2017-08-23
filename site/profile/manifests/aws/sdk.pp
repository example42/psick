# This class installs and configures Aws SDK gems
#
# @param ensure Define if to install (present), remote (absent) sdk gems
# @param install_gems The gems to install
# @param install_system_gems If to install danger gems on the system
# @param install_puppet_gems If to install danger gems via puppet gem
#
class profile::aws::sdk (
  String  $ensure              = 'present',
  Array   $install_gems        = [ 'aws-sdk-core' , 'aws-sdk' , 'retries' ],
  Boolean $install_system_gems = true,
  Boolean $install_puppet_gems = true,
) {
  include ::profile::ruby
  $install_gems.each | $gem | {
    if $install_system_gems {
      package { $gem:
        ensure          => $ensure,
        provider        => 'gem',
        require         => Class['profile::ruby'],
      }
    }
    if $install_puppet_gems {
      package { "puppet_${gem}":
        ensure          => $ensure,
        name            => $gem,
        provider        => 'puppet_gem',
        require         => Class['profile::ruby'],
      }
    }
  }
}
