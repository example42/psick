# Class profile::users::ad
# This class uses trlinkin/domain_membership for domain join on Windows
#
# @example Hiera configuration example
#   profile::users::ad::domain: 'my.ads.domain'
#   profile::users::ad::username: 'Domain Administrator'
#   profile::users::ad::password: 'secret'
#   profile::users::ad::create_machine_account: true
#   profile::users::ad::machine_ou: '$null'
#
class profile::users::ad (
  String $domain,
  String $username,
  String $password,
  String $machine_ou,
  Boolean $create_machine_account = true,
) {
  if $::kernel == 'Linux' {
    class { '::sssd':
      domains => $domain,
    }
  }
  if $::kernel == 'Windows' {
    $join_options = $create_machine_account ? {
      true  => '3',
      false => '1',
    }
    
    class { '::domain_membership':
      domain       => $domain,
      username     => $username,
      password     => $password,
      resetpw      => false,
      machine_ou   => $machine_ou,
      join_options => $join_options,
    }
  }
}
