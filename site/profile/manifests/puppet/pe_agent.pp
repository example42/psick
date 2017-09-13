# This class manages tp::test for PE Agents
#
class profile::puppet::pe_agent (
  Boolean $test_enable        = false,
  Boolean $manage_environment = false,
  Hash $settings              = {},
) {

  if $test_enable {
    Tp::Test {
      cli_enable => true,
      template   => '',
    }
    tp::test { 'puppet-agent': settings_hash => $settings }
  }

  service { 'puppet':
    ensure => 'running',
    enable => true,
  }

  # Set environment
  if $manage_environment {
    pe_ini_setting { 'agent conf file environment':
      ensure  => present,
      path    => '/etc/puppetlabs/puppet/puppet.conf',
      section => 'agent',
      setting => 'environment',
      value   => $environment,
      notify  => Service['puppet'],
    }
  }
}
