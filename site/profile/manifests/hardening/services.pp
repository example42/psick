# Generic class to remove unnecessary services
#
class profile::hardening::services (
  Array $services_to_remove        = [],
  Array $services_default,
  Boolean $remove_default_services = true,
) {

  $services = $remove_default_services ? {
    true  => $services_to_remove + $services_default,
    false => $services_to_remove,
  }

  $services.each |$pkg| {
    service { $pkg:
      ensure => stopped,
      enable => false,
    }
  }

}
