# Requires puppet/windowsfeature module
class profile::windows::features (
  Optional[Hash] $install,
  Optional[Hash] $defaults,
  Boolean $use_defaults,
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
