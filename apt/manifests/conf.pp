# Define apt::conf
#
# General apt main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
# Engine, pattern end line parameters can be tweaked for better behaviour
#
# Usage:
# apt::conf    { "mynetworks":  value => "127.0.0.0/8 10.42.42.0/24" }
#
define apt::conf($ensure, $content = false, $source = false) {
  require apt::params
  
  if $content {
    file {"${apt::params::confd_dir}/${name}":
      ensure  => $ensure,
      content => $content,
      before  => Exec["aptget_update"],
      notify  => Exec["aptget_update"],
    }
  }

  if $source {
    file {"${apt::params::confd_dir}/${name}":
      ensure => $ensure,
      source => $source,
      before  => Exec["aptget_update"],
      notify  => Exec["aptget_update"],
    }
  }
}

