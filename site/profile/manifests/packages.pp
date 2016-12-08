# Generic class to add custom single packages
#
#
class profile::packages (
  Array $packages_default,
  Array $packages_to_add        = [],
  Boolean $add_default_packages = true,
) {

  $packages = $add_default_packages ? {
    true  => $packages_to_add + $packages_default,
    false => $packages_to_add,
  }

  $packages.each |$pkg| {
    ensure_packages($pkg)
  }

}
