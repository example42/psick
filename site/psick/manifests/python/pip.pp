#
class psick::python::pip (
  $ensure = 'present',
) {
  tp::install { 'python-pip':
    ensure => $ensure,
  }
}
