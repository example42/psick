# This class installs fabric
#
class profile::python::fabric (
  $ensure = 'present',
) {
  package { 'fabric':
    ensure => $ensure,
  }
}
