#
class profile::monitor::sensu (
  Boolean $is_client   = true,
  Boolean $is_server   = false,
  Boolean $is_api      = false,
  Boolean $is_rabbitmq = false,

) {
  class { '::sensu':
    client => $is_client,
    server => $is_server,
    api    => $is_api,
  }
}
