class site::monitor (
  $icinga_class        = '',
  $nagiosplugins_class = '',
  $nrpe_class          = '',
  $newrelic_class      = '',
  $graphite_class      = '',
) {

  if $icinga_class or $icinga_class != '' {
    include $icinga_class
  }

  if $nagiosplugins_class or $nagiosplugins_class != '' {
    include $nagiosplugins_class
  }

  if $nrpe_class or $nrpe_class != '' {
    include $nrpe_class
  }

  if $newrelic_class or $newrelic_class != '' {
    include $newrelic_class
  }

  if $graphite_class or $graphite_class != '' {
    include $graphite_class
  }

}

