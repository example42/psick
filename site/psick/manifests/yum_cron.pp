# This class installs and configures yum-cron
#
# @param ensure Define if to install or remove yum-cron
# @param config_file_template The path of the erb template (as used in template)
#                             used for the content of yum-cron config file.
# @param options An hash of custon options to use in the config_file_template
#                Note: This is not a class parameter but a key lookup up via:
#                hiera_hash('psick::yum_cron::options', {} ) and merged with
#                a default hash of options
#
class psick::yum_cron (
  Enum['present','absent'] $ensure  = 'present',
  String $config_file_template = 'psick/yum_cron/yum-cron.conf.erb',
) {

  $options_default = {
    'update_cmd' => 'default',
    'update_messages' => 'yes',
    'download_updates' => 'yes',
    'apply_updates' => 'yes',
    'random_sleep' => '360',
    'system_name' => 'None',
    'emit_via' => 'stdio',
    'output_width' => '80',
    'email_from' => 'root@localhost',
    'email_to' => 'root',
    'email_host' => 'localhost',
    'group_list' => 'None',
    'group_package_types' => 'mandatory, default',
    'debuglevel' => '-2',
    'mdpolicy' => 'group:main',
  }
  $options_user=hiera_hash('psick::yum_cron::options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install { 'yum-cron':
    ensure => $ensure,
  }

  if $config_file_template != '' {
    ::tp::conf { 'yum-cron':
      ensure       => $ensure,
      template     => $config_file_template,
      options_hash => $options,
    }
  }

}
