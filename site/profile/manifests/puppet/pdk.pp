#
class profile::puppet::pdk (
  $ensure = 'present',
) {
  # Waiting for pdk repo
  #  package { 'pdk':
  #   ensure => $ensure,
  #}
}
