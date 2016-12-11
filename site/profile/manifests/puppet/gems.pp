# This class installs the gems needed to run Puppet with this control-repo
#
class profile::puppet::gems (
  Enum['present','absent'] $ensure      = 'present',
  Array $install_gems = [ 'r10k','deep_merge','hiera-eyaml' ],
) {
  $install_gems.each | $gem | {
    package { $gem:
      ensure   => $ensure,
      provider => 'gem',
    }
    package { "puppet_${gem}":
      ensure   => $ensure,
      name     => $gem,
      provider => 'puppet_gem',
    }
  }
}
