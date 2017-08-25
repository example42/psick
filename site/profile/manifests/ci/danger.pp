# This class installs and configures danger, used to automatically
# add comments to Merge/Push Requests during CI pipelines
# Danger homepage: http://danger.systems/
#
# @param ensure Define if to install (present), remote (absent) danger gems
# @param use_gitlab If GitLab (and the relevant danger gem) is used
# @param install_system_gems If to install danger gems on the system
# @param install_puppet_gems If to install danger gems via puppet gem
#
class profile::ci::danger (
  String $ensure               = 'present',
  Array $plugins               = [ ],
  Boolean $use_gitlab          = false,
  Boolean $install_system_gems = true,
  Boolean $install_puppet_gems = true,
) {
  include ::profile::ruby

  $all_gems = $use_gitlab ? {
    true  => ['danger-gitlab'] + $plugins,
    false => ['danger'] + $plugins,
  }

  $all_gems.each | $gem | {
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
