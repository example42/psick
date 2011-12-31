define apt::sources_list (
  $ensure = present,
  $source = false,
  $content = false) {

  require apt::params

  if $source {
    file {"${apt::params::sourcelistdir}/${name}.list":
      ensure => $ensure,
      source => $source,
      before  => Exec["${apt::params::update_command}"],
      notify  => Exec["${apt::params::update_command}"],
    }
  } else {
    file {"${apt::params::sourcelistdir}/${name}.list":
      ensure  => $ensure,
      content => $content,
      before  => Exec["${apt::params::update_command}"],
      notify  => Exec["${apt::params::update_command}"],
    }
  }
}
