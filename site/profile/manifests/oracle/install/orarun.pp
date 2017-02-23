#
class profile::oracle::install::orarun (
  $version               = $::profile::oracle::params::version_short,
  $version_short         = $::profile::oracle::params::version_short,
  $oracle_base           = $::profile::oracle::params::oracle_base,
  $oracle_home           = $::profile::oracle::params::oracle_home,
  $download_dir          = $::profile::oracle::params::download_dir,

  $oracle_user           = $::profile::oracle::params::oracle_user,
  $oracle_group          = $::profile::oracle::params::oracle_group,

  $oracle_sid            = 'orcl', # TODO Paramtrize better
  $sysconfig_template    = 'profile::oracle/orarun/sysconfig.erb',
  $profile_template      = 'profile::oracle/orarun/profile.erb',
) inherits ::profile::oracle::params {

  package { 'orarun': }
  file { '/etc/sysconfig/oracle':
    ensure  => present,
    content => template($sysconfig_template),
  }
  file { '/etc/profile.d/oracle.sh':
    ensure  => present,
    content => template($profile_template),
  }

  include profile::oracle::prerequisites::users
}
