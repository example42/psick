# External modules to installed by r10k in modules/ dir
# Here mostly at latest version for sample purposes.
# In working environments specific versions should be defined.

# Example42 extra modules
mod "example42/tp", :latest
mod "example42/tinydata", :latest
#mod "example42/psick", :latest
mod'example42/psick',
  :git => 'https://github.com/example42/puppet-psick'
# mod "example42/puppi", :latest
 
# Example42 v4.x modules (Used in various profiles)
mod'example42/docker',
  :git => 'https://github.com/example42/puppet-docker'
mod'example42/network',
  :git => 'https://github.com/example42/puppet-network'
mod'example42/apache',
  :git    => 'https://github.com/example42/puppet-apache',
  :branch => '4.x'
mod'example42/puppet',
  :git => 'https://github.com/example42/puppet-puppet',
  :branch => 'master'
mod'example42/rails',
  :git => 'https://github.com/example42/puppet-rails'
mod'example42/ansible',
  :git => 'https://github.com/example42/puppet-ansible'
mod'example42/icinga',
  :git => 'https://github.com/example42/puppet-icinga',
  :branch => '4.x'

# Third Party modules
mod "puppetlabs/concat", '3.0.0' # postgresql requires concat < 3.0.0
mod "puppetlabs/stdlib", :latest
mod "puppetlabs/vcsrepo", :latest
mod "puppetlabs/firewall", :latest
mod "puppetlabs/aws", :latest
mod "jdowning/rbenv", :latest
mod "trlinkin/noop", :latest
mod "puppetlabs/catalog_preview", :latest
mod "puppet/archive", :latest
mod "puppetlabs/inifile", :latest

# Used by profile::puppet::foss_server
mod 'puppetlabs/postgresql', :latest
mod 'puppetlabs/puppetdb', :latest
mod 'puppet/puppetserver',
  :git => "https://github.com/voxpupuli/puppet-puppetserver.git",
  :tag => '2.1.0'
mod 'puppetlabs/puppetserver_gem', :latest
mod 'puppet/r10k', :latest
mod 'puppetlabs/hocon', :latest
mod 'puppetlabs/apt', :latest
# mod 'puppet/puppetboard', :latest

# Used by profile::puppet::pe_code_manager
mod "pltraining/rbac", '0.0.5'

# Used by grafanadash server (puppet metrics)
mod 'grafanadash',
  :git => 'https://github.com/tuxmea/puppet-grafanadash.git',
  :branch => 'master'
mod 'dwerder/graphite', :latest

# Docker and Containers
mod "puppetlabs/dummy_service", :latest
#mod 'puppetlabs/image_build', :latest
#mod 'puppetlabs/rkt', :latest

# mod 'herculesteam-augeasproviders_sysctl', '2.2.0'
# mod "puppetlabs/firewall", :latest

# Used by profile::vpn::openvpn
# mod 'luxflux/openvpn',
#  :git => 'https://github.com/luxflux/puppet-openvpn'

# Used by profile::mongo
# mod 'puppetlabs/mongodb', :latest

# Used by profile::sudo::sudoers
# mod 'saz/sudo', :'3.1.0'

# Used by profile::vagrant
mod 'unibet/vagrant', :latest

# Used by profile::monitor::sensu
# mod 'sensu/sensu', :latest
# mod 'yelp/uchiwa', :latest
# mod 'puppet/rabbitmq', :latest
# mod 'puppet/staging', :latest

# Used by profile::windows 
# mod 'puppet/windowsfeature', :latest # :git => 'https://forge.puppet.com/voxpupuli/puppet-windowsfeature'
# mod 'thoward-windows_firewall', '0.3.4'
## mod 'puppet/windows_firewall', :latest # :git => 'https://forge.puppet.com/voxpupuli/puppet-windows_firewall'
# mod 'puppetlabs/registry', :latest
# mod 'puppetlabs/chocolatey', :latest
# mod 'puppetlabs/acl', :latest
# mod 'puppetlabs/dsc', :latest
# mod 'puppetlabs/powershell', :latest
# mod 'puppetlabs/reboot', :latest
# mod 'puppetlabs/wsus_client', :latest
# mod 'counsyl/windows', :git => 'https://github.com/counsyl/puppet-windows'
# mod 'trlinkin/domain_membership', :git => 'https://forge.puppet.com/trlinkin/domain_membership'

# Used by profile::users::static accounts_users_hash parameter
# mod 'puppetlabs/accounts', :latest
