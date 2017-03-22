#
class profile::proxy (
  Enum['present','absent'] $ensure,
  Boolean $configure_gem,
  Boolean $configure_puppet_gem,
  Boolean $configure_pip,
  Boolean $configure_system,
  Boolean $configure_repo,
  Boolean $force,
  Optional[Hash] $proxy_server = $::profile::settings::proxy_server,
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
    tools::profile::script { 'proxy':
      ensure  => $ensure,
      content => epp('profile/proxy/proxy.sh.epp'),
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
          epp    => 'site/profile/proxy/proxy.apt.epp',
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
