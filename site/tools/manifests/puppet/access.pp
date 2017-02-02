# Run Puppet access to create an authentication token
define tools::puppet::access (
  String $run_as_user                           = 'root',
  Optional[String] $deploy_password             = undef,
  Optional[String] $lifetime                    = '',
) {

  $user_home = $run_as_user ? {
    'root'  => '/root',
    default => "/home/${run_as_user}",
  }

  $lifetime_option = $lifetime ? {
    ''      => '',
    undef   => '',
    default => "--lifetime ${lifetime}",
  }

  $command_params="--username ${title} ${lifetime_option}"
  exec { "puppet-access ${title}":
    command => "echo '${deploy_password}' | /opt/puppetlabs/bin/puppet-access login ${command_params}",
    creates => "${user_home}/.puppetlabs/token",
    user    => $run_as_user,
  }
}
