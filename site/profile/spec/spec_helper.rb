# Derived from puppetlabs-ntp
#
require 'puppetlabs_spec_helper/module_spec_helper'
# require 'simplecov'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.manifest = File.join(fixture_path, 'manifests', 'site.pp')
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))
  # c.hiera_config = File.expand_path(File.join(__FILE__, '..', 'fixture', 'hiera.yaml'))
  # c.environmentpath = base_dir

  # Coverage generation
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end

#SimpleCov.start do
#  add_filter '/spec/'
#  add_filter '/.vendor/'
#end
require 'rspec-puppet-facts'
include RspecPuppetFacts

# Useful environment variables:
# FUTURE_PARSER=yes|no
# STRICT_VARIABLES=yes|no
# ORDERING=title-hash|manifest|random
# STRINGIFY_FACTS=no
# TRUSTED_NODE_DATA=yes
# #Example: FUTURE_PARSER=yes STRICT_VARIABLES=yes ORDERING=manifest rake spec
