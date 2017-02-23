#
class profile::oracle::install::tnsnames (
  String $version               = $::profile::oracle::params::version_short,
  String $oracle_base           = $::profile::oracle::params::oracle_base,
  String $oracle_home           = $::profile::oracle::params::oracle_home,
  String $download_dir          = $::profile::oracle::params::download_dir,

  String $oracle_user           = $::profile::oracle::params::oracle_user,
  String $oracle_group          = $::profile::oracle::params::oracle_group,

  String $database_type         = $::profile::oracle::params::database_type,

  String $tnsnames_name         = 'orcl',
  String $tnsnames_host         = '127.0.0.1',
  String $tnsnames_service_name = 'orcl',
  String $connectserver         = 'DEDICATED',
  String $db_port               = '1521',

) inherits ::profile::oracle::params {

  oradb::tnsnames{ $tnsnames_name:
    oracleHome         => $oracle_home,
    user               => $oracle_user,
    group              => $oracle_group,
    server             => { myserver => {
                              host     => $tnsnames_host,
                              port     => $db_port,
                              protocol => 'TCP',
                            },
                          },
    connectServiceName => $tnsnames_service_name,
    connectServer      => $connectserver,
  }

}
