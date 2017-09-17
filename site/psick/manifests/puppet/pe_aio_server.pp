# This class manages tp::test for a PE all in one server
#
class psick::puppet::pe_aio_server (
) {

  include ::psick::puppet::pe_console
  include ::psick::puppet::pe_puppetdb
  include ::psick::puppet::pe_agent
  include ::psick::puppet::pe_server

}
