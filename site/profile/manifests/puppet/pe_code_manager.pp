# This class configures PE Code Manager for automatic deployments
#
class profile::puppet::pe_code_manager (
  String $deploy_ssh_private_key_path = '/etc/puppetlabs/ssh/id-control_repo.rsa',
  Optional[String] $deploy_ssh_private_source   = undef,
  Optional[String] $pe_user                 = undef,
  Optional[String] $pe_password             = undef,
  Optional[String] $deploy_comment          = undef,
  Optional[String] $deploy_user             = 'root',
  Optional[String] $puppet_user             = 'pe-puppet',
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
  file { "/home/$puppet_user/.ssh":
    ensure => directory,
    owner  => $puppet_user,
  }
  tools::ssh_keygen { $deploy_user:
    comment => $deploy_comment,
    require => File["/home/$puppet_user/.ssh"]
  }
  file { $deploy_ssh_private_key_path:
    ensure => present,
    owner  => $puppet_user,
    mode   => '0400',
    source => $deploy_ssh_private_source,
  }

  #  tools::gitlab::deploy_key { :
  #    sshkey => $deploy_ssh_public_key
  #}
}
