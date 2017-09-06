require 'puppetlabs_spec_helper/rake_tasks'
require 'rspec/core/rake_task'
require 'puppet'

# abort if puppet version is to old
if Puppet::version < '4'
  puts 'YOU MUST RUN THIS WITH PUPPET 4.x'
  abort
end

exclude_paths = %w(
  vendor/**/*
  spec/**/*
  modules/**/*
  pkg/**/*
  tests/**/*
)

# the default lint task can not override the pattern configuration
Rake::Task[:lint].clear
PuppetLint::RakeTask.new(:lint) do |config|
  # Pattern of files to ignore
  config.ignore_paths = exclude_paths
  # Pattern of files to check, defaults to `**/*.pp`
  config.pattern = ['manifests/**/*.pp', 'site/**/*.pp']
  # List of checks to disable
  config.disable_checks = ['140chars', 'relative', 'class_inherits_from_params_class', 'empty_string_assignment']
  # Should the task fail if there were any warnings, defaults to false
  config.fail_on_warnings = true
  # Print out the context for the problem, defaults to false
  #config.with_context = true
  # Log Format
  #config.log_format = '%{path}:%{line}:%{check}:%{KIND}:%{message}'
end

# beaker is designed to run same tests on multiple nodes
# we have another usecase: multiple tests on multiple os
Rake::Task[:beaker].clear
RSpec::Core::RakeTask.new(:beaker) do |config|
  puts 'dont use beaker, use beaker_roles:<role> or all_roles instead'
  abort
end

# iterate over acceptance tests and create namespaced rake tasks
namespace :beaker_roles do
  Dir.glob("spec/acceptance/*_spec.rb") do |acceptance_test|
    test_name = acceptance_test.split('/').last.split('_spec').first
    RSpec::Core::RakeTask.new(test_name) do |t|
      t.rspec_opts = ['--color']
      t.pattern = acceptance_test
    end
  end
end

# find all rake tasks in beaker_roles namespace and run them in parallel
all_roles = []
Rake.application.in_namespace(:beaker_roles) do |beaker_roles_namespace|
  beaker_roles_namespace.tasks.each do |beaker_roles_tasks|
    all_roles << beaker_roles_tasks
  end
end
multitask :all_roles => all_roles

PuppetSyntax.exclude_paths = exclude_paths

# Blacksmith
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
  puts "Blacksmith needed only to push to the Forge"
end
# vim: syntax=ruby
