# This class manages tp::test for a PE all in one server
#
class profile::puppet::pe_aio_server (
) {

  include ::profile::puppet::pe_console
  include ::profile::puppet::pe_puppetdb
  include ::profile::puppet::pe_agent
  include ::profile::puppet::pe_server

}
