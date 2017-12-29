require 'beaker-rspec'
require 'beaker-hiera'
require 'beaker/puppet_install_helper'

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
      on(host, '/usr/bin/test -f /etc/puppetlabs/puppet/hiera.yaml && /bin/rm -f /etc/puppetlabs/puppet/hiera.yaml || echo     true')
      # remove existing production environment
      on(host, '/usr/bin/test -d /etc/puppetlabs/code/environments/production && /bin/rm -fr /etc/puppetlabs/code/environments/production || echo true')
      # re-create production environment directory
      on(host, '/usr/bin/test ! -d /etc/puppetlabs/code/environments/production && mkdir -p /etc/puppetlabs/code/environments/ production || echo true')
      # copy control-repo
      on(host, 'cp -r /tmp/production/{.git,environment.conf,hiera.yaml,hieradata,manifests,site,modules} /etc/puppetlabs/code/environments/production/')

      on(host, '/opt/puppetlabs/bin/puppet resource package git ensure=present')
      on(host, '/opt/puppetlabs/puppet/bin/gem install r10k')
      on(host, 'cd /etc/puppetlabs/code/environments/production && /opt/puppetlabs/puppet/bin/r10k puppetfile install -v') 
      on(host, '/opt/puppetlabs/puppet/bin/gem install hiera-eyaml')
      on(host, 'cd /etc/puppetlabs/puppet/ && /opt/puppetlabs/puppet/bin/eyaml createkeys')
    end
  end
end
