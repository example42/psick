# Generic class to remove unnecessary packages
#
class profile::hardening::packages (
  Array $packages_to_remove,
  Array $packages_default,
  Boolean $remove_default_packages = true,
) {

  $packages = $remove_default_packages ? {
    true  => $packages_to_remove + $packages_default,
    false => $packages_to_remove,
  }

  $packages.each |$pkg| {
    package { $pkg:
      ensure => absent,
    }
  }

}
