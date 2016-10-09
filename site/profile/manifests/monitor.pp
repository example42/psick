#
class profile::monitor (
  String $icinga_class        = '',
  String $nagiosplugins_class = '',
  String $nrpe_class          = '',
  String $newrelic_class      = '',
  String $snmp_class          = '',
  String $sysstat_class       = '',
) {

  if $icinga_class != '' {
    include $icinga_class
  }

  if $nagiosplugins_class != '' {
    include $nagiosplugins_class
  }

  if $nrpe_class != '' {
    include $nrpe_class
  }

  if $newrelic_class != '' {
    include $newrelic_class
  }

  if $snmp_class != '' {
    include $snmp_class
  }

  if $sysstat_class != '' {
    include $sysstat_class
  }

}
