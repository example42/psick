# This class installs fabric
#
class psick::python::fabric (
  $ensure = 'present',
) {
  package { 'fabric':
    ensure => $ensure,
  }
}
