# This class manages subscription to RedHat satellite or similar systems.
#
# @param rhn_server_url The url of the RHN server. If not defined an hiera
#                       lookup is done according to the underlying OS
# @param rhn_activation_key The activation key needed to access the RHN server.
#                           If not defined it's automatically calculated based
#                           on local custom defaults.
#
# @example Set rhn url for different OS:
#   profile::pre::rhn::redhat: 'http://10.1.4.20/XMLRPC'
#   profile::pre::rhn::oracle: 'http://10.1.4.23/XMLRPC'
#   profile::pre::rhn::sles: 'http://10.1.4.21/XMLRPC'
#
class profile::pre::rhn (
  String $rhn_server_url     = '',
  String $rhn_activation_key = '',
) {

  $real_rhn_server_url = $rhn_server_url ? {
    ''    => $::operatingsystem ? {
      'RedHat'      => hiera('profile::pre::rhn::redhat',''),
      'OracleLinux' => hiera('profile::pre::rhn::oracle',''),
      'SLES'        => hiera('profile::pre::rhn::sles',''),
      default       => '',
    },
    default => $rhn_activation_key,
  }

  $real_rhn_activation_key = $rhn_activation_key ? {
    ''    => $::operatingsystem ? {
      'RedHat'      => "2-RHEL${::operatingsystemmajrelease}-BASE",
      'OracleLinux' => "2-OL${::operatingsystemmajrelease}-BASE",
      'SLES'        => "2-SLES${::operatingsystemmajrelease}SP${::facts['os']['release']['minor']}-BASE",
      default       => '',
    },
    default => $rhn_activation_key,
  }

  if $real_rhn_activation_key != '' and $real_rhn_server_url != '' {
    exec { 'RHN Registration':
      command => "rhnreg_ks --serverUrl=${real_rhn_server_url} --activationkey=${real_rhn_activation_key} --force",
      creates => '/etc/sysconfig/rhn/systemid',
    }
  }

}
