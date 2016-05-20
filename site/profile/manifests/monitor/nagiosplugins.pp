class profile::monitor::nagiosplugins (
  Variant[Boolean,String] $ensure = present,
) {

  ::tp::install { 'nagios-plugins':
    ensure => $ensure,
  } 

}

