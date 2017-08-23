#
class profile::monitor::sensu (
  Boolean $is_client    = true,
  Boolean $is_server    = false,
  Boolean $is_api       = false,
  Boolean $is_rabbitmq  = false,
  Boolean $is_dashboard = false,

  String $subscriptions     = 'all',
  String $client_address    = $::ipaddress,
  String $rabbitmq_user     = 'sensu',
  String $rabbitmq_password = 'sensu',
  String $rabbitmq_vhost    = '/sensu',
) {
  class { '::sensu':
    client => $is_client,
    server => $is_server,
    api    => $is_api,
    rabbitmq_user     => $rabbitmq_user,
    rabbitmq_password => $rabbitmq_password,
    # rabbitmq_password => Sensitive($rabbitmq_password),
    rabbitmq_vhost    => $rabbitmq_vhost,
    rabbitmq_host     => $rabbitmq_host,
    subscriptions     => $subscriptions,
    client_address    => $client_address,
  }

  if $is_rabbitmq {
    include ::rabbitmq
    rabbitmq_user { $rabbitmq_user:
      admin    => true,
      password => $rabbitmq_password,
    }
    rabbitmq_vhost { $rabbitmq_vhost:
      ensure => present,
    }
    rabbitmq_user_permissions { "${rabbitmq_user}@${rabbitmq_vhost}":
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
    }
  }

  if $is_dashboard {
    include ::uchiwa
  }
}
