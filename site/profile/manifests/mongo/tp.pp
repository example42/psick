#
class profile::mongo::tp (
  String                 $template           = 'profile/mongo/mongod.conf.erb',
  String                 $ensure             = $::profile::mongo::ensure,
  Variant[Undef,String]  $key                = $::profile::mongo::key,
  Variant[Undef,String]  $default_password   = $::profile::mongo::default_password,
  String                 $replset            = $::profile::mongo::replset,
  String                 $replset_arbiter    = $::profile::mongo::replset_arbiter,
  Array                  $replset_members    = $::profile::mongo::replset_members,
  Variant[Undef,Hash]    $databases          = undef, # $::profile::mongo::databases,
  Variant[Undef,Hash]    $hostnames          = $::profile::mongo::hostnames,
  Boolean                $initial_master     = false,
  Boolean                $initial_router     = false,
  Array                  $shards             = [],
  Boolean                $auto_replica_setup = true,

  Variant[Undef,String]  $repo               = 'mongodb-org-3.2',
  String                 $mongos_template    = '',
) {

  $options=hiera_hash('profile::mongo::tp::options', { })
  $settings=hiera_hash('profile::mongo::tp::settings', { })

  $tp_settings = tp_lookup('mongodb','settings','tinydata','merge')
  $custom_settings = {
    package_name => 'mongodb-enterprise',
    service_name => 'mongod',
    config_file_path => '/etc/mongod.conf',
  }
  $all_settings = $tp_settings + $custom_settings + $settings

  $default_options = {
    bindIp          => $::ipaddress,
    keyFile         => $key ? { undef => '' , default => '/etc/mongo.key' },
    replSetName     => $replset,
    port            => '27017',
    dbPath          => '/data/mongodb',
    journal_enabled => true,
    storage         => true,
    sharding        => '',
    configDB        => '', # TODO: Calculate automatically
  }
  $all_options = $default_options + $options
  ::tp::install { 'mongodb':
    auto_repo     => false,
    settings_hash => $all_settings,
  }

  Tools::Mongo::Command {
    run_command => $auto_replica_setup,
    db_host     => $::ipaddress,
    db_port     => $all_options['port'],
  }

  tools::create_dir { $all_options['dbPath']:
    owner => $all_settings['process_user'],
    group => $all_settings['process_group'],
  }

  if $template != '' {
    ::tp::conf { 'mongodb':
      template      => $template,
      options_hash  => $all_options,
      settings_hash => $all_settings,
    }
  }
  if $key {
    ::tp::conf { 'mongodb::key':
      path          => '/etc/mongo.key',
      content       => $key,
      mode          => '0400',
      owner         => $all_settings['process_user'],
      group         => $all_settings['process_group'],
      settings_hash => $all_settings,
    }
  }


  # Quick and dirty TODO Automate mongo servers lookup
  if $hostnames {
    $hostnames.each|$ho,$ho_options| {
      host { $ho:
        ip     => $ho_options['ip'],
        before => Tp::Install['mongodb'],
      }
    }
  }

  if $all_options['replSetName'] != '' and $initial_master and $replset_members != [] {
    # Replica Setup
    tools::mongo::command { 'initiate_replicaset':
      template => 'profile/mongo/initiate_replicaset.js.erb',
      options  => {
        replSetName => $all_options['replSetName'],
        firstMember => $replset_members[0],
      },
    }
  }

  if $all_options['replSetName'] != '' and $initial_master and $replset_members != [] {
    # Replica members add
    $additional_members=$replset_members - $replset_members[0]
    $additional_members.each |$member| {
      tools::mongo::command { "add_member_${member}":
        template => 'profile/mongo/add_member.js.erb',
        options  => {
          member => $member,
        },
      }
    }
  }

  if $all_options['replSetName'] != '' and $initial_master and $replset_arbiter != '' {
    # Arbiter add
    tools::mongo::command { 'add_arbiter':
      template => 'profile/mongo/add_arbiter.js.erb',
      options  => { 'arbiter' => $replset_arbiter } ,
    }
  }

  if $initial_router and $shards != [] {
    # Replica members add
    $shards.each |String $shard| {
      $safe_shard=regsubst($shard, '/', '_', 'G')
      tools::mongo::command { "add_shard_${safe_shard}":
        template => 'profile/mongo/add_shard.js.erb',
        options  => {
          shard => $shard,
        },
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
        require => Tp::Install['mongodb'],
      }
      mongodb_user { $real_options['user']:
        ensure        => 'present',
        database      => $db,
        tries         => $real_options['tries'],
        roles         => $real_options['roles'],
        password_hash => $real_options['password_hash'],
        require       => Tp::Install['mongodb'],
      }
    }
  }

  if $mongos_template != '' {
    file { '/lib/systemd/system/mongos.service':
      ensure  => $ensure,
      content => template($mongos_template),
    }
  }
}
