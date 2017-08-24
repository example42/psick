#
class profile::puppet::pdk (
  $ensure = 'present',
) {
  package { 'pdk':
    ensure => $ensure,
  }
}
