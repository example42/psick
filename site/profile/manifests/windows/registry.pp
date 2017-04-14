# Requires puppetlabs/registry module
class profile::windows::registry (
  Optional[Hash] $keys,
  Optional[Hash] $defaults,
  Boolean $use_defaults,
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
