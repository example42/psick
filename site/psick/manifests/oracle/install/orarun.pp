#
class psick::oracle::install::orarun (
  $version               = $::psick::oracle::params::version_short,
  $version_short         = $::psick::oracle::params::version_short,
  $oracle_base           = $::psick::oracle::params::oracle_base,
  $oracle_home           = $::psick::oracle::params::oracle_home,
  $download_dir          = $::psick::oracle::params::download_dir,

  $oracle_user           = $::psick::oracle::params::oracle_user,
  $oracle_group          = $::psick::oracle::params::oracle_group,

  $oracle_sid            = 'orcl', # TODO Paramtrize better
  $sysconfig_template    = 'psick::oracle/orarun/sysconfig.erb',
  $psick_template      = 'psick::oracle/orarun/psick.erb',
) inherits ::psick::oracle::params {

  package { 'orarun': }
  file { '/etc/sysconfig/oracle':
    ensure  => file,
    content => template($sysconfig_template),
  }
  file { '/etc/psick.d/oracle.sh':
    ensure  => file,
    content => template($psick_template),
  }

  include $psick::oracle::prerequisites::users_class
}
