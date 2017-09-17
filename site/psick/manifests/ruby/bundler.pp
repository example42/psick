#
class psick::ruby::bundler (
  $ensure = 'present',
) {
  package { 'bundler':
    ensure   => $ensure,
    provider => 'gem',
  }
}
