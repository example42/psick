# Run Puppet access to create an authentication token
define tools::puppet::access (
  String $run_as_user               = 'root',
  Optional[String] $lifetime        = '',
  String $pe_user                   = $title,
  Optional[String] $pe_password     = undef,
  String $pe_console                = $servername,
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

  file { "${user_home}/.puppetaccess":
    owner   => $run_as_user,
    group   => $run_as_user,
    mode    => '0400',
    content => $pe_password,
    before  => Exec["puppet-access ${title}"],
  }
  $command_params="--username ${pe_user} ${lifetime_option} --service-url https://${pe_console}:4433/rbac-api"
  exec { "puppet-access ${title}":
    command     => "cat ${user_home}/.puppetaccess | /opt/puppetlabs/bin/puppet-access login ${command_params}",
    creates     => "${user_home}/.puppetlabs/token",
    user        => $run_as_user,
    cwd         => $user_home,
    environment => [ "HOME=${user_home}" ],
    #   logoutput => false,
  }
}
