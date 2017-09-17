# This class manages tp::test for PE Console
#
class psick::puppet::pe_console (
) {
  $nginx_settings = {
    package_name => 'pe-nginx',
    service_name => 'pe-nginx',
  }
  $activemq_settings = {
    package_name => 'pe-activemq',
    service_name => 'pe-activemq',
    log_dir_path => '/var/log/puppetlabs/activemq',
    log_file_path => '/var/log/puppetlabs/activemq/activemq.log',
  }

  Tp::Test {
    cli_enable => true,
    template   => '',
  }
  tp::test { 'nginx': settings_hash => $nginx_settings }
  tp::test { 'activemq': settings_hash => $activemq_settings }

}
