# This class manages the installation and initialisation of apache
#
class profile::apache (
  String                $ensure      = 'present',
  Optional[String] $install_class = 'profile::apache::tp',
) {

  if $install_class { contain $install_class }

}
