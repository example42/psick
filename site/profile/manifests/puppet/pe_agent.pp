# This class manages tp::test for PE Agents
#
class profile::puppet::pe_agent (
  Boolean $test_enable = true,
  Hash $settings       = {},
) {

  if $test_enable {
    Tp::Test {
      cli_enable => true,
      template   => '',
    }
    tp::test { 'puppet-agent': settings_hash => $settings }
  }
}
