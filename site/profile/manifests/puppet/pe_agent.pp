# This class manages tp::test for PE Agents
#
class profile::puppet::pe_agent (
) {
  $puppetagent_settings = {
  }

  Tp::Test {
    cli_enable => true,
    template   => '',
  }
  tp::test { 'puppet-agent': settings_hash => $puppetagent_settings }

}
