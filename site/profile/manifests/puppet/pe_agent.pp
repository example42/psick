# This class manages tp::test for PE Agents
#
class profile::puppet::pe_agent (
  Boolean $test_enable        = false,
  Boolean $manage_environment = false,
  Boolean $manage_noop        = false,
  Boolean $manage_service     = false,
  Boolean $noop_mode          = false,
  Optional[String] $default_notify = 'Service[puppet]',
  Hash $settings              = {},
) {

  if $test_enable {
    Tp::Test {
      cli_enable => true,
      template   => '',
    }
    tp::test { 'puppet-agent': settings_hash => $settings }
  }

  # Manage Puppet agent service
  if $manage_service {
    service { 'puppet':
      ensure => 'running',
      enable => true,
    }
  }

  # Set environment
  if $manage_environment {
    pe_ini_setting { 'agent conf file environment':
      ensure  => present,
      path    => '/etc/puppetlabs/puppet/puppet.conf',
      section => 'agent',
      setting => 'environment',
      value   => $environment,
      notify  => $default_notify,
    }
  }

  # Set noop mode
  if $manage_noop {
    pe_ini_setting { 'agent conf file noop':
      ensure  => present,
      path    => '/etc/puppetlabs/puppet/puppet.conf',
      section => 'agent',
      setting => 'noop',
      value   => $noop_mode,
      notify  => $default_notify,
    }
  }
}
