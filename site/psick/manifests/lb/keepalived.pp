# starting point for the keepalived-psick 
class psick::lb::keepalived (
  Enum['present','absent'] $ensure                     = 'present',

  Variant[String[1],Undef] $config_dir_source          = undef,
  String                   $config_file_template       = 'psick/lb/keepalived/keepalived.conf.erb',
) {

  $options_default = {
    'notification_email_from' => "info@${::domain}",
    'smtp_server'             => 'localhost',
    'smtp_connect_timeout'    => '30',
    'lvs_id'                  =>  $::hostname,
  }
  $options_user=hiera_hash('psick::lb::keepalived::options', {} )
  $options=merge($options_default,$options_user)
  # Install package
  ::tp::install { 'keepalived':
    ensure => $ensure,
  }
  # fill out given tpl, only if empty sting for tpl is given - nothing will be written
  # otherwise the default tpl will be used
  if $config_file_template != '' {
    ::tp::conf { 'keepalived':
      ensure       => $ensure,
      template     => $config_file_template,
      options_hash => $options,
    }
  }
  # ensure that the subdir for the balanced services is existing 
  # example: psick::lb::keepalived::config_dir_source: "puppet:///modules/psick/lb/keepalived/services/"
  ::tp::dir { 'keepalived::services':
    ensure => $ensure,
    path   => '/etc/keepalived/services',
    source => $config_dir_source,
  }
  # get entries from given hiera_array-KEY and for each entry:
  # split vs to get role to find correct mapping in hieradata for the configured role-loadbalancing-variables like
  # vip, vip_mask and options
  # write File for vrrp_instance via given function
  $virtualservers=hiera_array('virtualservers', [] )
  $virtualservers.each | String $vs | {
    $vs_split=split($vs,'-')
    $app_role=$vs_split[1]
    $server_role=getvar("::psick::settings::${app_role}_server")
    tools::keepalived::vrrp { $vs:
      ensure       => $ensure,
      vip          => $server_role['vip'],
      vip_mask     => pick($server_role['vip_mask'],'/32'),
      user_options => $options,
    }
    # for each configured port 
    # write File virtual_server-port.conf via given function
    if $server_role['port'] =~ Iterable {
      $server_role['port'].each | String $port_type , Integer $port | {
        tools::keepalived::vs { "${vs}-${port}":
          ensure       => $ensure,
          vip          => $server_role['vip'],
          vip_port     => $port,
          user_options => $options,
        }
      }
    }
  }
  # collect fragement which has to be placed in services/<zone>-<role>-<env>-<kind>.conf
  Concat::Fragment <<| tag == "lb_${::zone}-${::env}" |>>

}
