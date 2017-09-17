# This class manages tp::test for PE Puppetdb
#
class psick::puppet::pe_puppetdb (
) {
  $puppetdb_settings = {
    package_name => 'pe-puppetdb',
    service_name => 'pe-puppetdb',
  }
  $postgresql_settings = {
    package_name => 'pe-postgresql',
    service_name => 'pe-postgresql',
    log_dir_path => '/var/log/puppetlabs/postgresql',
    log_file_path => [ '/var/log/puppetlabs/postgresql/pgstartup.log' ,
    '/var/log/puppetlabs/postgresql/postgresql-*.log' ],
  }

  Tp::Test {
    cli_enable => true,
    template   => '',
  }
  tp::test { 'puppetdb': settings_hash => $puppetdb_settings }
  tp::test { 'postgresql': settings_hash => $postgresql_settings }

}
