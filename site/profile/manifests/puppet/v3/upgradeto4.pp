# == p_agent
#
class profile::puppet::v3::upgradeto4 (
  $ensure                     = 'present',

  $config_file_template       = undef,
  $config_dir_source          = undef,

  $server_class               = undef,
  $install_puppetdb           = false,
) {

  $real_config_file_template = $config_file_template ? {
    undef   => $server_class ? {
      ''      => 'profile/puppet/v4/puppet.conf.erb',
      undef   => 'profile/puppet/v4/puppet.conf.erb',
      default => 'profile/puppet/v4/puppet.conf-server.erb',
    },
    default => $config_file_template,
  }

  $options_default = {
    server => 'puppet',
  }
  $options_user=hiera_hash('profile::puppet::options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install3 { 'puppet-agent':
    ensure => $ensure,
  }

  ::tp::conf3 { 'puppet-agent':
    ensure       => $ensure,
    template     => $real_config_file_template,
    options_hash => $options,
  }

  ::tp::dir3 { 'puppet-agent':
    ensure => $ensure,
    source => $config_dir_source,
  }

}
