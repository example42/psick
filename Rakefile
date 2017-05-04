require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-lint/tasks/puppet-lint'

PuppetSyntax.exclude_paths = ['spec/fixtures/**/*', 'vendor/**/*']
if Puppet.version.to_f < 4.0
  PuppetSyntax.exclude_paths << "types/**/*"
  PuppetSyntax.exclude_paths << "functions/**/*"
  PuppetSyntax.exclude_paths << /manifests\/\D+\.pp/
end
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ["pkg/**/*.pp", 'spec/**/*.pp', 'tests/**/*.pp', "vendor/**/*.pp"]

# Blacksmith
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
  puts "Blacksmith needed only to push to the Forge"
end

# Puppet 3 compatibility testing
if RUBY_VERSION < "2.0.0"
  PuppetSyntax.exclude_paths << /manifests\/\D+.pp/
  PuppetLint.configuration.ignore_paths << /manifests\/\D+pp/
  Rake::Task[:spec_standalone].clear
  RSpec::Core::RakeTask.new(:spec_standalone) do |t|
    t.pattern = 'spec/defines/*3_spec.rb'
  end
end
