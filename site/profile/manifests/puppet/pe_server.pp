# This class manages tp::test for PE server
#
class profile::puppet::pe_server (
) {
  $puppetserver_settings = {
    package_name => 'pe-puppetserver',
    service_name => 'pe-puppetserver',
  }

  Tp::Test {
    cli_enable => true,
    template   => '',
  }
  tp::test { 'puppetserver': settings_hash => $puppetserver_settings }

}
