# This class installs the gems needed to run Puppet with this control-repo
#
class profile::puppet::gems (
  Enum['present','absent'] $ensure = 'present',
  Array $install_gems = [ 'r10k','deep_merge','hiera-eyaml' ],
  Array $install_options           = [ ],
  Boolean $install_system_gems     = true,
  Boolean $install_puppet_gems     = true,
) {

  $install_gems.each | $gem | {
    if $install_system_gems {
      package { $gem:
        ensure          => $ensure,
        install_options => $install_options,
        provider        => 'gem',
      }
    }
    if $install_puppet_gems {
      package { "puppet_${gem}":
        ensure          => $ensure,
        name            => $gem,
        install_options => $install_options,
        provider        => 'puppet_gem',
      }
    }
  }
}
