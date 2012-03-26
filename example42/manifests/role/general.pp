class example42::role::general {

  Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

  class { 'puppet':
    mode => $hostname ? {
      foreman => 'server',
      default => 'client',
    },
    server => 'foreman.lab42.it',
    db     => 'mysql',
    db_name => 'puppet',
    db_server => 'localhost',
    db_user => 'puppet',
    db_password => 'mys3cr3tp4ss0rd',
    nodetool => 'foreman', 
  }

  class { 'nrpe': }
  class { 'openssh': }

#  include hosts
#  include users
#  include rsyslog
#  include openssh
#  include logrotate
#  include cron
#  include sysctl
#  include timezone
#  include ntp
#  include rootmail
#  include postfix
#  include snmpd
#  include monit
#  include munin
#  include nrpe
#  include mcollective
#  include rsync

  case $operatingsystem {
    'debian','ubuntu','mint': { include apt } 
    'redhat','centos','scientific': { include yum } 
  }

}
