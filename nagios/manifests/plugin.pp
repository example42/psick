define nagios::plugin(
    $ensure = present
){
  file{$name:
    path => $hardwaremodel ? {
      'x86_64' => "/usr/lib64/nagios/plugins/$name",
      default => "/usr/lib/nagios/plugins/$name",
    },
    ensure => $ensure,
    source => "puppet://$server/modules/nagios/plugins/$name",
    require => Package['nagios-plugins'],
    owner => root, group => 0, mode => 0755;
  }
}
