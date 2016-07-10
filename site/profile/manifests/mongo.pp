#
#
class profile::mongo (
  String                 $ensure   = 'present',
  Variant[Undef,String]  $key      = undef,
  Variant[Undef,String]  $replset  = undef,
  Variant[Undef,String]  $default_password = undef,
  Variant[Undef,String]  $replset_arbiter = undef,
  Variant[Undef,Array]   $replset_members = [ ],
  Variant[Undef,Boolean] $shardsrv  = undef,
  Variant[Undef,Hash]    $databases = undef,
  Variant[Undef,Hash]    $hostnames = undef,
) {

  class { '::mongodb::globals': manage_package_repo => true } ->
  class { '::mongodb::client': } ->
  class { '::mongodb::server':
    shardsvr => $shardsvr,
    replset  => $replset,
    replset_members => $replset_members,
    bind_ip  => [ '0.0.0.0' ],  
    auth     => true,
    keyfile  => '/etc/mongo.key',
    key      => $key,
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
        password_hash => mongodb_password("${db}_user",pick_undef($db_options['password'],$default_password)),
        tries         => 10,
      }
      $real_options = $db_options + $default_options 
      mongodb_database { $db:
        ensure  => 'present',
        tries   => $real_options['tries'],
        require => Class['mongodb::server'],
      }
      mongodb_user { $real_options['user']:
        ensure   => 'present',
        database => $db,
        tries    => $real_options['tries'],
        roles    => $real_options['roles'],
        password_hash => $real_options['password_hash'],
        require  => Class['mongodb::server'],
      }
    }
  }  
 
}
