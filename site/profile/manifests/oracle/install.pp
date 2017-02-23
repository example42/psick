# Wrapper class to install Oracle components
#
class profile::oracle::install (
  Optional[String] $install_db_class       = '::profile::oracle::install::db',
  Optional[String] $install_em_class       = undef,
  Optional[String] $install_dbclient_class = undef,
  Optional[String] $install_grid_class     = undef,
) {

  if $install_db_class and $install_db_class != '' {
    include $install_db_class
  }
  if $install_em_class and $install_em_class != '' {
    include $install_em_class
  }
  if $install_dbclient_class and $install_dbclient_class != '' {
    include $install_dbclient_class
  }
  if $install_grid_class and $install_grid_class != '' {
    include $install_grid_class
  }

}
