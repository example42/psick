#
class psick::ruby::rake (
  $ensure = 'present',
) {
  package { 'rake':
    ensure   => $ensure,
    provider => 'gem',
  }
}
