#
class profile::ruby (
  $ensure = 'present',
) {
  tp::install { 'ruby':
    ensure => $ensure,
  }
}
