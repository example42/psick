# External modules to installed by r10k in modules/ dir
# IMPORTANT: Here most modules are at latest version for sample purposes.
# In working environments specific fixed versions should be defined.
# Some modules might need to be uncommented to make specific profiles work

# Here we place hieradata in a separated module.
# We use control-repo branch if exists, or production as default
mod 'example42/hieradata',
  :git => 'https://github.com/example42/psick-hieradata',
  :branch => :control_branch,
  :default_branch => 'production'

# Puppet 6 Core Modues
mod 'puppetlabs/mount_core', :latest
mod 'puppetlabs/augeas_core', :latest
mod 'puppetlabs/zfs_core', :latest
mod 'puppetlabs/yumrepo_core', :latest
mod 'puppetlabs/host_core', :latest
mod 'puppetlabs/selinux_core', :latest
mod 'puppetlabs/zone_core', :latest
mod 'puppetlabs/cron_core', :latest
mod 'puppetlabs/sshkeys_core', :latest
mod 'puppetlabs/nagios_core', :latest
mod 'puppetlabs/mailalias_core', :latest
mod 'puppetlabs/macdslocal_core', :latest
mod 'puppetlabs/maillist_core', :latest
mod 'puppetlabs/k5login_core', :latest

# Example42 modules
# From Forge
mod 'example42/tp', :latest
mod 'example42/tinydata', :latest
mod 'example42/psick', :latest
mod 'example42/network', :latest
mod 'example42/tp_profile', :latest

mod 'example42/deployments',
  :git => 'https://github.com/example42/puppet-deployments'

# Third Party modules
mod 'puppetlabs/concat', :latest
mod 'puppetlabs/stdlib', :latest
mod 'puppetlabs/vcsrepo', :latest
mod 'puppetlabs/firewall', :latest
mod 'puppetlabs/inifile', :latest
mod 'puppetlabs/catalog_preview', :latest
mod 'jdowning/rbenv', :latest
mod 'trlinkin/noop', :latest
mod 'puppet/archive', :latest
# mod 'puppetlabs/aws', :latest

# Requirements for cd4pe
mod 'puppetlabs-cd4pe', :latest
# #mod 'puppetlabs-concat', '4.2.1'
# #mod 'puppetlabs-hocon', '1.1.0'
mod 'puppetlabs-puppet_authorization', :latest
# #mod 'puppetlabs-stdlib', '6.2.0'
mod 'puppetlabs-docker', :latest
# #mod 'puppetlabs-apt', '7.3.0'
mod 'puppetlabs-translate', :latest
mod 'puppetlabs-pipelines', :latest
mod 'puppetlabs-cd4pe_jobs', :latest

# Used by psick::puppet::foss_server
# mod 'puppetlabs-bolt_shim', '0.3.0'
# mod 'puppetlabs/postgresql', :latest
# mod 'puppetlabs/puppetdb', :latest
# mod 'puppet/puppetserver', :latest
# mod 'puppetlabs/puppetserver_gem', :latest
# mod 'puppet/r10k', :latest
# mod 'puppetlabs/hocon', :latest
# mod 'puppetlabs/apt', :latest
# mod 'puppet/puppetboard', :latest

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

# Used by psick::vagrant
mod 'unibet/vagrant', :latest

# Used by psick::icinga
mod 'icinga/icinga2', :latest

# Used by psick::sensu
mod 'sensu/sensu', :latest
mod 'yelp/uchiwa', :latest
mod 'puppet/rabbitmq', :latest
# deprecated: mod 'puppet/staging', :latest

# Used by windows profiles
# mod 'puppet/windowsfeature', :latest # :git => 'https://github.com/voxpupuli/puppet-windowsfeature'
# mod 'thoward-windows_firewall', '0.3.4'
## mod 'puppet/windows_firewall', :latest # :git => 'https://github.com/voxpupuli/puppet-windows_firewall'
# mod 'puppetlabs/registry', :latest
# mod 'puppetlabs/chocolatey', :latest
# mod 'puppetlabs/acl', :latest
# mod 'puppetlabs/dsc', :latest
# mod 'puppetlabs/powershell', :latest
# mod 'puppetlabs/reboot', :latest
# mod 'puppetlabs/wsus_client', :latest
# mod 'counsyl/windows', :git => 'https://github.com/counsyl/puppet-windows'
# mod 'trlinkin/domain_membership', :git => 'https://github.com/trlinkin/domain_membership'

# Used by Mac profiles
# mod 'thekevjames-homebrew', :latest

# Used by psick::users when module=puppetlabs
# mod 'puppetlabs/accounts', :latest

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
