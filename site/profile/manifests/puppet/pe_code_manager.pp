# This class configures PE Code Manager for automatic deployments
#
class profile::puppet::pe_code_manager (
  String $deploy_ssh_private_key_path = '/etc/puppetlabs/ssh/id-control_repo.rsa',
  Optional[String] $deploy_ssh_private_source = undef,
  String $deploy_ssh_public_key_path = '/etc/puppetlabs/ssh/id-control_repo.rsa.pub',
  Optional[String] $deploy_ssh_public_source = undef,
  Optional[String] $pe_user                 = undef,
  Optional[String] $pe_password             = undef,
  Optional[String] $deploy_comment          = undef,
  Optional[String] $deploy_user             = 'root',
  Optional[String] $puppet_user             = 'pe-puppet',
  Optional[String] $puppet_user_home        = undef,
  Optional[String] $lifetime                = '5y',
) {

  file { '/etc/puppetlabs/ssh':
    ensure => directory,
    owner  => $puppet_user,
  }

  tools::puppet::access { $pe_user:
    deploy_password => $pe_password,
    run_as_user     => $deploy_user,
    lifetime        => $lifetime,
  }

  $real_puppet_user_home = pick($puppet_user_home,"/home/${puppet_user}/.ssh")
  file { $real_puppet_user_home:
    ensure => directory,
    owner  => $puppet_user,
  }
  tools::ssh_keygen { $deploy_user:
    comment => $deploy_comment,
    require => File[$real_puppet_user_home],
  }

  file { $deploy_ssh_private_key_path:
    ensure => present,
    owner  => $puppet_user,
    mode   => '0400',
    source => pick($deploy_ssh_private_source,"file:///home/${puppet_user}/.ssh/id_rsa"),
  }
  file { $deploy_ssh_public_key_path:
    ensure => present,
    owner  => $puppet_user,
    mode   => '0400',
    source => pick($deploy_ssh_public_source,"file:///home/${puppet_user}/.ssh/id_rsa.pub"),
  }


  #  tools::gitlab::deploy_key { :
  #    sshkey => $deploy_ssh_public_key
  #}
}
