# This class manages monitoring by exposing parameters that define the classes
# to include for different monitoring tools
#
# @example Include the monitor classes for check_mk and snmp:
#   profile::monitor::check_mk_class: '::profile::monitor::check_mk'
#   profile::monitor::snmp_class: '::profile::monitor::snmpd'
#
# @params nagiosplugins_class Name of the class that manages Nagios plugins
# @params check_mk_class Name of the class that manages Check MK
# @params snmp_class Name of the class that manages SNMP
# @params ganglia_class Name of the class that manages Ganglia
# @params *_class Name of the class that manages the relevant monitoring tool
#
class profile::monitor (
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

  if $nagiosplugins_class != '' {
    contain $nagiosplugins_class
  }

  if $check_mk_class != '' {
    contain $check_mk_class
  }

  if $snmp_class != '' {
    contain $snmp_class
  }

  if $ganglia_class != '' {
    contain $ganglia_class
  }

  if $icinga_class != '' {
    contain $icinga_class
  }

  if $sensu_class != '' {
    contain $sensu_class
  }

  if $nrpe_class != '' {
    contain $nrpe_class
  }

  if $newrelic_class != '' {
    contain $newrelic_class
  }

  if $sysstat_class != '' {
    contain $sysstat_class
  }

}
