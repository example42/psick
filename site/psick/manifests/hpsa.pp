# This class manages HP SA client installation and configuration
#
# @param sa_agent_base_url The base URL (excluded filename) from where to
#                          download the HP agent installation file
# @param version The version of the HP SA agent package to use
# @param sa_agent_file The name of the file to download. Default is calculated
#                      according to OS and version
# @param opsw_gw_addr The string to use to define opsw_gw_addr during registration
#
class psick::hpsa (
  String $sa_agent_base_url = '',
  String $version           = '65.0.70477.0',
  String $sa_agent_file     = '',
  String $opsw_gw_addr      = '',
) {

  $sa_agent_logfile  = "/var/log/opsware/agent/HPSAagent-${version}_install_verbose.log"

  $solaris_arch = $::architecture ? {
    'x86_64' => '-X86',
    default  => '',
  }
  $real_sa_agent_file = $sa_agent_file ? {
    ''      => $::operatingsystem ? {
      'RedHat'      => "opsware-agent-${version}-linux-${::operatingsystemmajrelease}SERVER-X86_64",
      'OracleLinux' => "opsware-agent-${version}-linux-OEL${::operatingsystemmajrelease}-X86_64",
      'SLES'        => "opsware-agent-${version}-linux-SLES-${::operatingsystemmajrelease}-X86_64",
      'Ubuntu'      => "opsware-agent-${version}-linux-UBUNTU-${::operatingsystemmajrelease}-X86_64",
      'Solaris'     => "opsware-agent-${version}-solaris-${::operatingsystemmajrelease}${solaris_arch}",
    },
    default => $sa_agent_file,
  }

  # HP SA Setup
  if $sa_agent_base_url != '' and $opsw_gw_addr != '' {
    archive { "/usr/local/bin/${real_sa_agent_file}":
      source => "${sa_agent_base_url}/${real_sa_agent_file}",
      notify => Exec['SA agent permissions'],
    }
    exec { 'SA agent permissions':
      command     => "chmod 700 /usr/local/bin/${real_sa_agent_file}",
      refreshonly => true,
      notify      => Exec['SA registration'],
    }
    exec { 'SA registration':
      timeout => 600,
      command => "/usr/local/bin/${real_sa_agent_file} -s -f --opsw_gw_addr ${opsw_gw_addr} --force_sw_reg --loglevel trace --logfile ${sa_agent_logfile} --force_new_device 2>&1",
      creates => '/opt/opsware/agent/bin/python',
    }
    service { 'opsware-agent':
      ensure  => running,
      enable  => true,
      require => Exec['SA registration'],
    }
  }
}
