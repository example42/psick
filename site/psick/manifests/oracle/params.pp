#
class psick::oracle::params (
  $version           = '12.1.0.1',
  $version_short     = '12.1',

  $containing_folder = 'linuxamd64_12c_database',
  $source_baseurl    = undef,

  $oracle_base       = '/export/oracle',
  $oracle_home       = '/export/oracle/product/12.1/db',
  $datafile_path     = '/export/oracle/oradata',
  $recovery_path     = '/export/oracle/flash_recovery_area',

  $download_dir      = '/opt/orainstall',

  $database_type     = 'SE',

  $oracle_user       = 'oracle',
  $oracle_group      = 'dba',
  $install_group     = 'oinstall',
  $oper_group        = 'oper',

) {

}
