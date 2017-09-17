#
class psick::ruby (
  $ensure = 'present',
) {
  tp::install { 'ruby':
    ensure => $ensure,
  }
}
