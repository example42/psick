#
class profile::ruby::bundler (
  $ensure = 'present',
) {
  package { 'bundler':
    ensure   => $ensure,
    provider => 'gem',
  }
}
