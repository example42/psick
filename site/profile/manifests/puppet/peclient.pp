# 
class profile::puppet::peclient {
  service { 'puppet' :
    ensure => running,
    enable => true,
  }
}
