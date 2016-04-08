# == Class: profile::puppet::v4::agent_tp
#
class profile::puppet::v4::agent_tp (
  $ensure                     = 'present',

  $config_file_template       = undef,
  $config_dir_source          = undef,

  $create_symlinks            = true,

  $server_class               = undef,
) {

  $real_config_file_template = $config_file_template ? {
    undef   => $server_class ? {
      ''      => 'profile/puppet4/puppet.conf.erb',
      undef   => 'profile/puppet4/puppet.conf.erb',
      default => 'profile/puppet4/puppet.conf-server.erb',
    },
    default => $config_file_template,
  }

  $options_default = {
    server => 'puppet',
  }
  $options_user=hiera_hash('puppet_options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install { 'puppet-agent':
    ensure => $ensure,
  }

  ::tp::conf { 'puppet-agent':
    ensure       => $ensure,
    template     => $real_config_file_template,
    options_hash => $options,
  }

  ::tp::dir { 'puppet-agent':
    ensure => $ensure,
    source => $config_dir_source,
  }

  if $create_symlinks {
    file { '/usr/local/bin/puppet':
      ensure => link,
      target => '/opt/puppetlabs/bin/puppet',
    }
    file { '/usr/local/bin/facter':
      ensure => link,
      target => '/opt/puppetlabs/bin/facter',
    }
  }

  if $server_class {
    include $server_class
  }

}
