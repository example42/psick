# This class installs and configures danger, used to automatically
# add comments to Merge/Push Requests during CI pipelines
# Danger homepage: http://danger.systems/
#
# @param ensure Define if to install (present), remote (absent) danger gems
# @param install_gems The gems to install
# @param install_system_gems If to install danger gems on the system
# @param install_puppet_gems If to install danger gems via puppet gem
#
class profile::ci::danger (
  String $ensure               = 'present',
  Array $install_gems          = [ 'danger' , 'danger-gitlab' ],
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
