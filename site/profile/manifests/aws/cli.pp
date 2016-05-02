class profile::aws::cli (
  $ensure = 'present',
) {

  include profile::python::pip
  tp::install { 'awscli':
    ensure => $ensure,
  }
 
}
