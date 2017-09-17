#
#
class psick::mongo::puppetlabs (
  String                 $ensure           = $::psick::mongo::ensure,
  Variant[Undef,String]  $key              = $::psick::mongo::key,
  Variant[Undef,String]  $replset          = $::psick::mongo::replset,
  Variant[Undef,String]  $default_password = $::psick::mongo::default_password,
  Variant[Undef,String]  $replset_arbiter  = $::psick::mongo::replset_arbiter,
  Variant[Undef,Array]   $replset_members  = $::psick::mongo::replset_members,
  Variant[Undef,Boolean] $shardsvr         = $::psick::mongo::shardsvr,
  Variant[Undef,Hash]    $databases        = $::psick::mongo::databases,
  Variant[Undef,Hash]    $hostnames        = $::psick::mongo::hostnames,
) {

  class { '::mongodb::globals': manage_package_repo => true }
  -> class { '::mongodb::client': }
  -> class { '::mongodb::server':
    shardsvr        => $shardsvr,
    replset         => $replset,
    replset_members => $replset_members,
    bind_ip         => [ '0.0.0.0' ],
    auth            => true,
    keyfile         => '/etc/mongo.key',
    key             => $key,
  }

  # Quick and dirty TODO Automate mongo servers lookup
  if $hostnames {
    $hostnames.each|$ho,$ho_options| {
      host { $ho:
        ip     => $ho_options['ip'],
        before => Class['mongodb::server'],
      }
    }
  }
  if $databases {
    $databases.each|$db,$db_options| {
      $default_options = {
        user          => "${db}_user",
        roles         => [ 'readWrite' ],
        password_hash => mongodb_password("${db}_user",pick_default($db_options['password'],$default_password)),
        tries         => 10,
      }
      $real_options = $db_options + $default_options
      mongodb_database { $db:
        ensure  => 'present',
        tries   => $real_options['tries'],
        require => Class['mongodb::server'],
      }
      mongodb_user { $real_options['user']:
        ensure        => 'present',
        database      => $db,
        tries         => $real_options['tries'],
        roles         => $real_options['roles'],
        password_hash => $real_options['password_hash'],
        require       => Class['mongodb::server'],
      }
    }
  }
}
