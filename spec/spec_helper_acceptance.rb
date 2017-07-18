require 'beaker-rspec'

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
    end
  end
end
