# This class configures PE Code Manager for automatic deployments
#
class psick::puppet::pe_code_manager (
  Boolean $generate_ssh_keys                = true,
  String $deploy_ssh_private_key_path = '/etc/puppetlabs/ssh/id-control_repo.rsa',
  Optional[String] $deploy_ssh_private_source = undef,
  String $deploy_ssh_public_key_path = '/etc/puppetlabs/ssh/id-control_repo.rsa.pub',
  Optional[String] $deploy_ssh_public_source = undef,
  Optional[String] $pe_user                 = undef,
  Optional[String] $pe_password             = undef,
  Optional[String] $pe_email                = 'root@localhost',
  Optional[String] $deploy_comment          = undef,
  Optional[String] $deploy_user             = 'root',
  Optional[String] $puppet_user             = 'pe-puppet',
  Optional[String] $puppet_user_home        = undef,
  Optional[String] $lifetime                = '5y',
) {

  if $pe_user and $pe_password {
    rbac_user { $pe_user:
      ensure       => 'present',
      name         => $pe_user,
      display_name => 'Puppet code deploy user',
      email        => $pe_email,
      password     => $pe_password,
      roles        => [ 'Code Deployers' ],
      before       => Tools::Puppet::Access[$pe_user],
    }
    tools::puppet::access { $pe_user:
      pe_password => $pe_password,
      run_as_user => $deploy_user,
      lifetime    => $lifetime,
    }
  }

  if $generate_ssh_keys {
    file { '/etc/puppetlabs/ssh':
      ensure => directory,
      owner  => $puppet_user,
    }

    $real_deploy_user_home = $deploy_user ? {
      'root'  => '/root',
      default => "/home/${deploy_user}",
    }

    tools::ssh_keygen { $deploy_user:
      comment => $deploy_comment,
    }

    file { $deploy_ssh_private_key_path:
      ensure => file,
      owner  => $puppet_user,
      mode   => '0400',
      source => pick($deploy_ssh_private_source,"file://${real_deploy_user_home}/.ssh/id_rsa"),
    }
    file { $deploy_ssh_public_key_path:
      ensure => file,
      owner  => $puppet_user,
      mode   => '0400',
      source => pick($deploy_ssh_public_source,"file:///${real_deploy_user_home}/.ssh/id_rsa.pub"),
    }

  }

  # TODO Automate Upload of ssh public key to gitlab
  #  tools::gitlab::deploy_key { :
  #    sshkey => $deploy_ssh_public_key
  #  }

}
