# This class installs PE client tools
#
class psick::puppet::pe_client_tools (
  Enum['present','absent'] $ensure = present,
) {

  package { 'pe-client-tools':
    ensure => $ensure,
  }

}
