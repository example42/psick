require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

support_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec/support/*.rb'))
Dir[support_path].each {|f| require f}

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules/site') + ':' + File.join(fixture_path, 'modules/r10k')
  c.manifest_dir = File.join(fixture_path, '../../manifests')
  c.manifest = File.join(fixture_path, '../../manifests/site.pp')
  c.hiera_config = File.join(fixture_path, '../../hiera.yaml')
  c.fail_fast = true
end

at_exit { RSpec::Puppet::Coverage.report! }
