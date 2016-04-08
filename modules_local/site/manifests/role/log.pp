class site::role::log {

  tp::install3 { 'redis': }
  tp::install3 { 'logstash': }
  tp::install3 { 'elasticsearch': }

}
