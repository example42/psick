# Requires puppetlabs/registry module
class psick::windows::registry (
  Optional[Hash] $keys     = {},
  Optional[Hash] $defaults = {},
  Boolean $use_defaults    = true,
) {

  $registry = $use_defaults ? {
    true  => $keys + $defaults,
    false => $keys,
  }

  $registry.each |$k,$v| {
    registry::value { $k:
      * => $v,
    }
  }
}
