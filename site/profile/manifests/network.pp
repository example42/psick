# This class wraps network management using example42-network module
#
class profile::network (
) {

  include ::network
  $routes = hiera_hash('profile::network::routes', {})
  $routes.each |$r,$o| {
    ::network::mroute { $r:
      routes => $o[routes],
    }
  }

  $interfaces = hiera_hash('profile::network::interfaces', {})
  $interfaces.each |$r,$o| {
    ::network::interface { $r:
      * => $o,
    }
  }
}
