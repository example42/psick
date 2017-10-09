require 'beaker-rspec'
require 'beaker-hiera'

hosts.each do |host|
  # Install Puppet
  install_puppet_agent_on(host)
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  # Readable test descriptions
  c.formatter = :documentation
  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      on(host, '/opt/puppetlabs/bin/puppet resource package git ensure=present')
      on(host, '/opt/puppetlabs/bin/puppet resource file /etc/puppetlabs/code/environments/production/modules ensure=absent recurse=true force=true')
      on(host, '/opt/puppetlabs/puppet/bin/gem install r10k')
      on(host, 'cd /etc/puppetlabs/code/environments/production && /opt/puppetlabs/puppet/bin/r10k puppetfile install -v') 
      on(host, '/opt/puppetlabs/puppet/bin/gem install hiera-eyaml')
      on(host, 'cd /etc/puppetlabs/puppet/ && /opt/puppetlabs/puppet/bin/eyaml createkeys')
    end
  end
end
