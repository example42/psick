class profile::python::fabric (
  $ensure = 'present',
) {
  tp::install { 'fabric':
    ensure => $ensure,
  }
}
