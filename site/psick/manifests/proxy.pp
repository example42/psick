# Configures proxy settings on different package managers
#
# @param ensure If to add or remove the proxy configuration
# @param configure_gem Configure proxy for gem
# @param configure_puppet_gem Configure proxy for puppet gem
# @param configure_pip Configure proxy for pip
# @param configure_system Export proxy global vars on startup script
# @param configure_repo Configure proxy on package repos
# @param force Enforce resource apply even if noop is true
# @param proxy_server Hash with the proxy server data. Default is based on
#   psick::settings::proxy_server
#
class psick::proxy (
  Enum['present','absent'] $ensure = 'present',
  Boolean $configure_gem           = true,
  Boolean $configure_puppet_gem    = true,
  Boolean $configure_pip           = true,
  Boolean $configure_system        = true,
  Boolean $configure_repo          = true,
  Boolean $force                   = false,
  Optional[Hash] $proxy_server     = $::psick::settings::proxy_server,
) {

  if $force {
    info('Forced execution. However is set noop')
    noop(false)
  }

  if !empty($proxy_server) {
    if !empty($proxy_server['user']) and !empty($proxy_server['password']) {
      $proxy_credentials = "${proxy_server['user']}:${proxy_server['password']}@"
    } else {
      $proxy_credentials = ''
    }
    $proxy_url = "${proxy_server['scheme']}://${proxy_credentials}${proxy_server['host']}:${proxy_server['port']}"
  }
  if $configure_gem and !empty($proxy_server) {
    ini_setting { 'proxy_gem':
      ensure            => $ensure,
      path              => '/etc/gemrc',
      key_val_separator => ': ',
      setting           => 'gem',
      value             => "-p ${proxy_url}",
    }
  }
  if $configure_puppet_gem and !empty($proxy_server) {
    file { '/opt/puppetlabs/puppet/etc':
      ensure => directory,
    }
    ini_setting { 'proxy_puppet_gem':
      ensure            => $ensure,
      path              => '/opt/puppetlabs/puppet/etc/gemrc',
      key_val_separator => ': ',
      setting           => 'gem',
      value             => "-p ${proxy_url}",
    }
  }
  if $configure_pip and !empty($proxy_server) {
    ini_setting { 'proxy_pip':
      ensure            => $ensure,
      path              => '/etc/pip.conf',
      key_val_separator => '=',
      section           => 'global',
      setting           => 'proxy',
      value             => "${proxy_server['host']}:${proxy_server['port']}",
    }
  }
  if $configure_system and $proxy_server != {} {
    tools::psick::script { 'proxy':
      ensure  => $ensure,
      content => epp('psick/proxy/proxy.sh.epp'),
      # Template has to be evaluated here: it uses local scope vars
    }
  }
  if $configure_repo and !empty($proxy_server) {
    case $::osfamily {
      'RedHat': {
        ini_setting { 'proxy_yum':
          ensure            => $ensure,
          path              => '/etc/yum.conf',
          key_val_separator => '=',
          section           => 'main',
          setting           => 'proxy',
          value             => "${proxy_server[scheme]}://${proxy_server['host']}:${proxy_server['port']}",
        }
        if has_key($proxy_server,'user') and has_key($proxy_server,'password') {
          ini_setting { 'proxy_user_yum':
            ensure            => $ensure,
            path              => '/etc/yum.conf',
            key_val_separator => '=',
            section           => 'main',
            setting           => 'proxy_username',
            value             => $proxy_server['user'],
          }
          ini_setting { 'proxy_password_yum':
            ensure            => $ensure,
            path              => '/etc/yum.conf',
            key_val_separator => '=',
            section           => 'main',
            setting           => 'proxy_password',
            value             => $proxy_server['password'],
          }
        }
      }
      'Debian': {
        file { '/etc/apt/apt.conf.d/80proxy':
          ensure => $ensure,
          epp    => 'site/psick/proxy/proxy.apt.epp',
        }
      }
      default: {
        notify { 'Proxy':
          message => "No proxy configuration available for ${::osfamily} repos",
        }
      }
    }
  }
}
