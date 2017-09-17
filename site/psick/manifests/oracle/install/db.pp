#
class psick::oracle::install::db (
  # Full Oracle version (Default: 12.1.0.1)
  $version           = $::psick::oracle::params::version,

  # Short Oracle version (Default: 12.1)
  $version_short     = $::psick::oracle::params::version_short,

  # Base name of the installation zips (excluded _XofX.zip suffix)
  # Must macth the used Oracle version (Default: linuxamd64_12c_database)
  $containing_folder = $::psick::oracle::params::containing_folder,

  # Base Url from where to retrieve the installation zips (file names excluded)
  # If not provided you must manually place the installation files
  # in the defined $download_dir
  $source_baseurl    = $::psick::oracle::params::source_baseurl,

  # Oracle paths and users
  $oracle_base       = $::psick::oracle::params::oracle_base,
  $oracle_home       = $::psick::oracle::params::oracle_home,
  $datafile_path     = $::psick::oracle::params::datafile_path,
  $recovery_path     = $::psick::oracle::params::recovery_path,
  $oracle_user       = $::psick::oracle::params::oracle_user,
  $oracle_group      = $::psick::oracle::params::oracle_group,
  $install_group     = $::psick::oracle::params::install_group,
  $oper_group        = $::psick::oracle::params::oper_group,

  # Where to download / copy the files used for installation
  $download_dir      = $::psick::oracle::params::download_dir,

  # The Oracle database product to install. Default: SE
  # Possible values:
  # EE     : Enterprise Edition
  # SE     : Standard Edition
  # SEONE  : Standard Edition One
  $database_type     = $::psick::oracle::params::database_type,

  # Set to true to remove installation files (zips and exploded dir)
  # after installation
  $cleanup_installfiles = false,

) inherits ::psick::oracle::params {

  $install_source = "file://${download_dir}"

  if $source_baseurl {
    wget::fetch { "${containing_folder}_1of2.zip":
      source      => "${source_baseurl}/${containing_folder}_1of2.zip",
      destination => "${download_dir}/${containing_folder}_1of2.zip",
      before      => Oradb::Installdb["${version}_${::kernel}"],
      require     => File[$download_dir],
    }
    wget::fetch { "${containing_folder}_2of2.zip":
      source      => "${source_baseurl}/${containing_folder}_2of2.zip",
      destination => "${download_dir}/${containing_folder}_2of2.zip",
      before      => Oradb::Installdb["${version}_${::kernel}"],
      require     => File[$download_dir],
    }
  }

  file { $download_dir:
    ensure => directory,
  }

  oradb::installdb { "${version}_${::kernel}":
    version                => $version,
    file                   => $containing_folder,
    databaseType           => $database_type,
    oracleBase             => $oracle_base,
    oracleHome             => $oracle_home,
    user                   => $oracle_user,
    group                  => $oracle_group,
    group_install          => $install_group,
    group_oper             => $oper_group,
    downloadDir            => $download_dir,
    remoteFile             => true,
    puppetDownloadMntPoint => $install_source,
    cleanup_installfiles   => $cleanup_installfiles,
  }

}
