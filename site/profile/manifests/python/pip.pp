class profile::python::pip (
  $ensure = 'present',
) {
  package { 'python-pip':
    ensure => $ensure,
  }
}
