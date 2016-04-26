class profile::aws::setup (
) {

  include profile::python::pip
  package { 'awscli':
    provider => pip,
  }
 
}
