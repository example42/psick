# Requires puppet/windowsfeature module
class psick::windows::features (
  Optional[Hash] $install  = {},
  Optional[Hash] $defaults = {},
  Boolean $use_defaults    = true,
) {

  $features = $use_defaults ? {
    true  => $install + $defaults,
    false => $install,
  }

  $features.each |$k,$v| {
    windowsfeature { $k:
      * => $v,
    }
  }
}
