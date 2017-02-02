# This class installs Gsnglia packages and starts the gmond service
#
class profile::monitor::ganglia (
  Array $packages,
) {

  $packages.each |$pkg| {
    ensure_packages($pkg)
  }

  #TODO: Verify for other OS
  #TODO: Verify if other cofnigs are needed
  service { 'gmond':
    ensure => 'running',
    enable => true,
  }
}
