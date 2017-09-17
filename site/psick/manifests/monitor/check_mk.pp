# This class manages the installation and configuation of checkMK
#
# @param server The monitor server hostname
# @param port The port to use
# @param interval The check interval
#
class psick::monitor::check_mk (
  Optional[String] $server    = undef,
  String $port                = '6522',
  String $interval            = '120',
) {

  $packages = $::osfamily ? {
    'RedHat' => [ 'check_mk-agent' , 'check_mk-agent-logwatch' ] ,
    'Debian' => [ 'check_mk-agent' , 'check_mk-agent-logwatch' ] ,
    'Suse'   => [ 'check_mk-agent' , 'check_mk-agent-logwatch' , 'check_mk-plugins'],
    'RedHat' => [ 'check_mk-agent' , 'check_mk-agent-logwatch' ,
    'check_mk-plugins'],
    'Suse' => [ 'check_mk-agent' , 'check_mk-agent-logwatch' ,
    'check_mk-plugins'],
    default  => [],
  }

  $init_script = $::osfamily ? {
    'Debian' => '/etc/default/cmk-passiv',
    default  => '/etc/sysconfig/cmk-passiv',
  }

  $packages.each |$pkg| {
    ensure_packages($pkg)
  }

  if $packages != [] {
    service { 'cmk-passiv':
      ensure  => running,
      enable  => true,
      require => Package['check_mk-agent'],
    }

    if $server {
      file { $init_script:
        content => "${server} ${interval} ${port}\n",
        notify  => Service['cmk-passiv'],
        require => Package['check_mk-agent'],
      }
    }
  }

}
