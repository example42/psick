#
#
class profile::mongo (
  String                 $ensure           = 'present',
  Variant[Undef,String]  $key              = undef,
  Variant[Undef,String]  $replset          = undef,
  Variant[Undef,String]  $default_password = undef,
  Variant[Undef,String]  $replset_arbiter  = undef,
  Variant[Undef,Array]   $replset_members  = [ ],
  Variant[Undef,Boolean] $shardsvr         = undef,
  Variant[Undef,Hash]    $databases        = undef,
  Variant[Undef,Hash]    $hostnames        = undef,

  String                 $mongo_class      = 'profile::mongo::tp',
) {

  if $mongo_class != '' {
    include $mongo_class
  }
}
