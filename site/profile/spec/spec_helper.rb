require 'simplecov'
SimpleCov.start do
 add_filter '/spec/'
 add_filter '/.vendor/'
end

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

spec_path = File.join(__FILE__, '..')
profile_module_path = File.expand_path(File.join(spec_path, '..'))
site_module_path = File.expand_path(File.join(profile_module_path, '../..'))
fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
#  c.manifest_dir = File.join(fixture_path, 'manifests')
#  c.manifest = File.join(site_module_path, 'manifests', 'site.pp')
  c.hiera_config = File.expand_path(File.join(fixture_path, '../fixtures/hiera.yaml'))

  # Coverage generation
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end



# Useful environment variables:
# FUTURE_PARSER=yes|no
# STRICT_VARIABLES=yes|no
# ORDERING=title-hash|manifest|random
# STRINGIFY_FACTS=no
# TRUSTED_NODE_DATA=yes
# #Example: FUTURE_PARSER=yes STRICT_VARIABLES=yes ORDERING=manifest rake spec
