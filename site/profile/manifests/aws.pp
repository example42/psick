#
class profile::aws (
  String $cli_class          = '::profile::aws::cli',
  String $setup_class        = '::profile::aws::setup',
) {

  if $cli_class and $cli_class != '' {
    contain $cli_class
  }
  if $setup_class and $setup_class != '' {
    contain $setup_class
  }

}
