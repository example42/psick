# This class manages the installation and initialisation of rabbitmq
#
class psick::rabbitmq (
  String           $ensure             = 'present',
  Boolean          $auto_prerequisites = true,
  Optional[String] $template           = undef,
  Optional[String] $init_template      = undef,
  Hash             $options            = { },
) {

  include ::rabbitmq
}
