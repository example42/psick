#
define tools::oracle::instance (
  $version               = $::profile::oracle::params::version_short,
  $version_short         = $::profile::oracle::params::version_short,

  $oracle_base           = $::profile::oracle::params::oracle_base,
  $oracle_home           = $::profile::oracle::params::oracle_home,
  $download_dir          = $::profile::oracle::params::download_dir,

  $oracle_user           = $::profile::oracle::params::oracle_user,
  $oracle_group          = $::profile::oracle::params::oracle_group,

  $dbinstance_type       = 'MULTIPURPOSE',
  $action                = 'create',
  $db_name               = $title,
  $db_domain             = $::domain,
  $db_port               = '1521',
  $sys_passwd            = 'oracle',
  $system_passwd         = 'oracle',
  $data_file_path        = '/export/oracle/oradata',
  $recovery_path         = '/export/oracle/flash_recovery_area',
  $character_set         = 'AL32UTF8',
  $national_character_set = 'UTF8',
  $init_params_hash      = { },
  $sample_schema         = 'FALSE',
  $memory_percentage     = '40',
  $memory_total          = '800',
  $em_configuration      = undef,

  $container_database    = false,
  $autostart             = true,
) {

  $real_container_database = $container_database ? {
    undef  => $version_short ? {
      '12.1'  => true,
      default => false,
    },
    default => $container_database,
  }

  oradb::net { $title:
    oracleHome  => $oracle_home,
    version     => $version_short,
    user        => $oracle_user,
    group       => $oracle_group,
    downloadDir => $download_dir,
    dbPort      => $db_port,
    require     => Class[$::profile::oracle::install_db_class],
  }

  db_listener { $title:
    ensure          => 'running',
    oracle_base_dir => $oracle_base,
    oracle_home_dir => $oracle_home,
    os_user         => $oracle_user,
    require         => Oradb::Net[$title],
  }

  $default_init_params = {
    'open_cursors'        => '1000',
    'processes'           => '600',
    'job_queue_processes' => '4',
  }

  $init_params=merge($default_init_params, $init_params_hash)

  oradb::database{ $title:
    oracleBase              => $oracle_base,
    oracleHome              => $oracle_home,
    version                 => $version_short,
    user                    => $oracle_user,
    group                   => $oracle_group,
    action                  => $action,
    dbName                  => $db_name,
    dbDomain                => $db_domain,
    dbPort                  => $db_port,
    sysPassword             => $sys_passwd,
    systemPassword          => $system_passwd,
    dataFileDestination     => $data_file_path,
    recoveryAreaDestination => $recovery_path,
    characterSet            => $character_set,
    nationalCharacterSet    => $national_character_set,
    initParams              => $init_params,
    sampleSchema            => $sample_schema,
    memoryPercentage        => $memory_percentage,
    memoryTotal             => $memory_total,
    databaseType            => $dbinstance_type,
    emConfiguration         => $em_configuration,
#    template                => 'dbtemplate_12.1',
    require                 => Db_listener[$title],
    downloadDir             => $download_dir,
    containerDatabase       => $real_container_database,
  }

  if $real_container_database == true {
    oradb::database_pluggable{'pdb1':
      ensure                   => 'present',
      oracle_home_dir          => $oracle_home,
      version                  => $version_short,
      user                     => $oracle_user,
      group                    => $oracle_group,
      source_db                => $title,
      pdb_name                 => 'pdb1',
      pdb_admin_username       => 'pdb_adm',
      pdb_admin_password       => 'Welcome01',
      pdb_datafile_destination => "${data_file_path}/${title}/pdb1",
      create_user_tablespace   => true,
      log_output               => true,
      require                  => Oradb::Database[$title],
    }
  }
  if $autostart == true {
    oradb::autostartdatabase{ $title:
      oracleHome => $oracle_home,
      user       => $oracle_user,
      dbName     => $db_name,
      require    => Oradb::Database[$title],
    }
    db_control { $title:
      ensure                  => 'running', #running|start|abort|stop
      instance_name           => $title,
      oracle_product_home_dir => $oracle_home,
      os_user                 => $oracle_user,
      require                 => Oradb::Database[$title],
    }
  }
}
