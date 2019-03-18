# Here we place hieradata in a separated module.
# We use control-repo branch if exists, or production as default
mod 'graduway/hieradata',
  :git => 'https://github.com/graduway/psick-hieradata',
  :branch => :control_branch,
  :default_branch => 'production'

# External modules to installed by r10k in modules/ dir
# Here mostly at latest version for sample purposes.
# In working environments specific versions should be defined.
# Tags, branches and commits can be used. Ie:
# mod 'example42/tp', '2.1.0'

# Example42 modules
# From Forge
mod 'example42/tp', :latest
mod 'example42/tinydata', :latest
# mod 'example42/psick', :latest
mod 'example42/psick',
  :git => 'https://github.com/example42/puppet-psick'
mod 'example42/network', :latest
mod 'example42/puppet',
  :git => 'https://github.com/example42/puppet-puppet',
  :branch => 'master'

# Third Party modules
mod 'puppetlabs-ntp', :latest
mod 'puppetlabs/concat', '3.0.0' # postgresql requires concat < 3.0.0
mod 'puppetlabs/stdlib', :latest
mod 'puppet-extlib', '2.1.0'
mod 'puppetlabs/vcsrepo', :latest
mod 'puppetlabs/firewall', :latest
mod 'puppetlabs-aws', :latest
mod 'jdowning/rbenv', :latest
mod 'trlinkin/noop', :latest
mod 'puppetlabs/catalog_preview', :latest
mod 'puppet/archive', :latest
mod 'puppetlabs/inifile', :latest
mod 'puppet/windows_env', :latest
mod 'graduway/ec2tagfacts',
  :git => 'https://github.com/graduway/ec2tagfacts',
  :branch => 'master'

# Used by psick::puppet::foss_server
mod 'puppetlabs/postgresql', :latest
mod 'puppetlabs/puppetdb', :latest
mod 'puppet/puppetserver', :latest
mod 'puppetlabs/puppetserver_gem', :latest
mod 'puppet/r10k', :latest
mod 'puppetlabs/hocon', :latest
mod 'puppetlabs/apt', '6.2.1'
mod 'puppet/puppetboard', :latest

# Used by psick::puppet::pe_code_manager
mod 'pltraining/rbac', '0.0.5'

# Used by grafanadash server (puppet metrics)
#mod 'grafanadash',
#  :git => 'https://github.com/tuxmea/puppet-grafanadash.git',
#  :branch => 'master'
#mod 'dwerder/graphite', :latest

# Docker and Containers
mod 'puppetlabs/dummy_service', :latest
#mod 'puppetlabs/image_build', :latest
#mod 'puppetlabs/rkt', :latest

# mod 'herculesteam-augeasproviders_sysctl', '2.2.0'
# mod 'puppetlabs/firewall', :latest

# Used by psick::vpn::openvpn
# mod 'puppet-openvpn', '7.1.0'
mod 'openvpn',
  :git => 'https://github.com/graduway/puppet-openvpn.git',
  :branch => 'mail-env'

mod 'fail2ban',
  :git => 'https://github.com/graduway/puppet-fail2ban.git',
  :branch => 'protocol'

# Used by psick::vagrant
mod 'unibet/vagrant', :latest

mod 'puppet/rabbitmq', :latest
mod 'puppet/staging', :latest

# Used by windows profiles
mod 'puppet/windowsfeature', :latest # :git => 'https://github.com/voxpupuli/puppet-windowsfeature'
# mod 'thoward-windows_firewall', '0.3.4'
## mod 'puppet/windows_firewall', :latest # :git => 'https://github.com/voxpupuli/puppet-windows_firewall'
mod 'puppetlabs/registry', :latest
mod 'puppetlabs/chocolatey', :latest
mod 'puppetlabs/acl', :latest
mod 'puppetlabs/dsc', :latest
mod 'puppetlabs/powershell', :latest
mod 'puppetlabs/reboot', :latest
mod 'puppetlabs-iis', :latest

# mod 'puppetlabs/wsus_client', :latest
# mod 'counsyl/windows', :git => 'https://github.com/counsyl/puppet-windows'
# mod 'trlinkin/domain_membership', :git => 'https://github.com/trlinkin/domain_membership'

# Used by psick::users when module=puppetlabs
mod 'puppetlabs/accounts', :latest
mod 'oxc-postfix', '1.0.2'
## mod 'puppet-fail2ban', '2.2.0'
mod 'example42-profile', '2.0.4'


# Choria
# mod 'choria/choria', :latest
# mod 'choria/mcollective_choria', :latest
# mod 'choria/mcollective_agent_filemgr', :latest
# mod 'choria/mcollective_agent_package', :latest
# mod 'choria/mcollective_agent_puppet', :latest
# mod 'choria/mcollective_agent_service', :latest
# mod 'choria/mcollective_agent_bolt_tasks', :latest
# mod 'choria/mcollective_agent_service', :latest
# mod 'choria/mcollective_util_actionpolicy', :latest

