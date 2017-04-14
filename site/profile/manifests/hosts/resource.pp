#
class profile::hosts::resource (
  Optional[Hash] $hosts,
  Optional[Hash] $defaults,
  Boolean $use_defaults,
) {

  $all_hosts = $use_defaults ? {
    true  => $hosts + $defaults,
    false => $hosts,
  }

  $all_hosts.each |$k,$v| {
    host { $k:
      * => $v,
    }
  }
}
