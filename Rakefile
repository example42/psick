require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-lint/tasks/puppet-lint'

PuppetSyntax.exclude_paths = ['spec/fixtures/**/*', 'vendor/**/*']
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ["pkg/**/*.pp", 'spec/**/*.pp', 'tests/**/*.pp', "vendor/**/*.pp"]

