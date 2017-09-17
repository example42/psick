# This class manages the installation and initialisation of apache
#
class psick::apache (
  String                $ensure      = 'present',
  Optional[String] $install_class = 'psick::apache::tp',
) {

  if $install_class { contain $install_class }

}
