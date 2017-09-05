# Generic class to add custom single packages
#
# @param packages_default The packages installed by default (according to the
#                         underlying OS)
# @param add_default_packages If to actually install the default packages
# @param packages_to_add An array of custom extra packages to install
#
class profile::packages (
  Array $packages_default       = [],
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
