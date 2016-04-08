# == Class: site::puppet4
#
class site::puppet4 (
  $ensure                     = 'present',

  $config_dir_source          = undef,
  $config_file_template       = 'site/puppet4/puppet.conf.erb',

  $create_symlinks            = true,
) {

  $options_default = {
    server => 'puppet',
  }
  $options_user=hiera_hash('puppet_options', {} )
  $options=merge($options_default,$options_user)

  if $ensure == 'absent' {
    ::tp::uninstall3 { 'puppet-agent': }
  } else {
    ::tp::install3 { 'puppet-agent': }
  }

  ::tp::dir3 { 'puppet-agent':
    ensure => $ensure,
    source => $config_dir_source,
  }
  ::tp::conf3 { 'puppet-agent':
    ensure       => $ensure,
    template     => $config_file_template,
    options_hash => $options,
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
}
