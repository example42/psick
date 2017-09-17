# This class manages monitoring by exposing parameters that define the classes
# to include for different monitoring tools
#
# @example Include the monitor classes for check_mk and snmp:
#   psick::monitor::check_mk_class: '::psick::monitor::check_mk'
#   psick::monitor::snmp_class: '::psick::monitor::snmpd'
#
# @example Don't manage any monitor class or resource. (Default manage is true)
#   psick::monitor::manage: false
#
# @params manage If to actually include classes and manage resources here.
# @params enable If to enable or not montioring for the server (note: the psicks
#   included  *_class params have to honour this variable)
# @params hostname Entry point for the hostname to use as default by different
#   monitoring psicks. What's configured here will be the hostname
#   visible on manage monitoring tools (if they are included from here and honour
#   psick::monitor::hostname as default)
# @params ip Entry point for the IP to use as default by different
#   monitoring psicks
# @params interface Entry point for the interface to use as default by different
#   monitoring psicks
# @params nagiosplugins_class Name of the class that manages Nagios plugins
# @params nagiosplugins_class Name of the class that manages Nagios plugins
# @params check_mk_class Name of the class that manages Check MK
# @params snmp_class Name of the class that manages SNMP
# @params ganglia_class Name of the class that manages Ganglia
# @params *_class Name of the class that manages the relevant monitoring tool
#
class psick::monitor (
  Boolean $manage             = $::psick::settings::monitor_manage,
  Boolean $enable             = $::psick::settings::monitor_enable,
  String $hostname            = $facts['networking']['fqdn'],
  String $ip                  = $facts['networking']['ip'],
  String $interface           = $facts['networking']['primary'],

  String $nagiosplugins_class = '',
  String $check_mk_class      = '',
  String $snmp_class          = '',
  String $ganglia_class       = '',
  String $icinga_class        = '',
  String $sensu_class         = '',
  String $nrpe_class          = '',
  String $newrelic_class      = '',
  String $sysstat_class       = '',
) {

  if $manage and $nagiosplugins_class != '' {
    contain $nagiosplugins_class
  }

  if $manage and $check_mk_class != '' {
    contain $check_mk_class
  }

  if $manage and $snmp_class != '' {
    contain $snmp_class
  }

  if $manage and $ganglia_class != '' {
    contain $ganglia_class
  }

  if $manage and $icinga_class != '' {
    contain $icinga_class
  }

  if $manage and $sensu_class != '' {
    contain $sensu_class
  }

  if $manage and $nrpe_class != '' {
    contain $nrpe_class
  }

  if $manage and $newrelic_class != '' {
    contain $newrelic_class
  }

  if $manage and $sysstat_class != '' {
    contain $sysstat_class
  }

}
