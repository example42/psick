class profile::monitor (
  String $icinga_class        = '',
  String $nagiosplugins_class = '',
  String $nrpe_class          = '',
  String $newrelic_class      = '',
  String $graphite_class      = '',
) {

  if ::tp::is_something($icinga_class) {
    include $icinga_class
  }

  if ::tp::is_something($nagiosplugins_class) {
    include $nagiosplugins_class
  }

  if ::tp::is_something($nrpe_class) {
    include $nrpe_class
  }

  if ::tp::is_something($newrelic_class) {
    include $newrelic_class
  }

  if ::tp::is_something($graphite_class) {
    include $graphite_class
  }

}

