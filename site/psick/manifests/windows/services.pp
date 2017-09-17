# Manages Windows services using Puppet service type
class psick::windows::services (
  Optional[Hash] $managed  = {},
  Optional[Hash] $defaults = {},
  Boolean $use_defaults    = true,
) {

  $services = $use_defaults ? {
    true  => $managed + $defaults,
    false => $managed,
  }

  $services.each |$k,$v| {
    service { $k:
      * => $v,
    }
  }
}
