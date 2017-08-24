source ENV['GEM_SOURCE'] || 'https://rubygems.org'

# Determines what type of gem is requested based on place_or_version.
def gem_type(place_or_version)
  if place_or_version =~ /^git:/
    :git
  elsif place_or_version =~ /^file:/
    :file
  else
    :gem
  end
end

# Find a location or specific version for a gem. place_or_version can be a
# version, which is most often used. It can also be git, which is specified as
# `git://somewhere.git#branch`. You can also use a file source location, which
# is specified as `file://some/location/on/disk`.
def location_for(place_or_version, fake_version = nil)
  if place_or_version =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { git: $1, branch: $2, require: false }].compact
  elsif place_or_version =~ /^file:\/\/(.*)/
    ['>= 0', { path: File.expand_path($1), require: false }]
  else
    [place_or_version, { require: false }]
  end
end

# Used for gem conditionals
supports_windows = false
ruby_version_segments = Gem::Version.new(RUBY_VERSION.dup).segments
minor_version = "#{ruby_version_segments[0]}.#{ruby_version_segments[1]}"

group :development do
  gem "puppet-module-win-default-r#{minor_version}",   require: false, platforms: ['mswin', 'mingw', 'x64_mingw']
  gem "puppet-module-win-dev-r#{minor_version}",       require: false, platforms: ['mswin', 'mingw', 'x64_mingw']
  gem "puppet-module-posix-dev-r#{minor_version}",     require: false, platforms: 'ruby'
  gem "puppet-module-posix-default-r#{minor_version}", require: false, platforms: 'ruby'
  gem 'json_pure', '<= 2.0.1',                         require: false if Gem::Version.new(RUBY_VERSION.dup) < Gem::Version.new('2.0.0')
  gem 'fast_gettext',                                  require: false if Gem::Version.new(RUBY_VERSION.dup) < Gem::Version.new('2.1.0')
end

group :system_tests do
  gem "puppet-module-posix-system-r#{minor_version}",          require: false, platforms: 'ruby'
  gem "puppet-module-win-system-r#{minor_version}",            require: false, platforms: ['mswin', 'mingw', 'x64_mingw']
  gem 'beaker', *location_for(ENV['BEAKER_VERSION']) if ENV['BEAKER_VERSION']
  gem 'beaker-abs', *location_for(ENV['BEAKER_ABS_VERSION']) if ENV['BEAKER_ABS_VERSION']
  gem 'beaker-hostgenerator', *location_for(ENV['BEAKER_HOSTGENERATOR_VERSION'])
  gem 'beaker-pe',                                             require: false
  gem 'beaker-rspec', *location_for(ENV['BEAKER_RSPEC_VERSION']) if ENV['BEAKER_RSPEC_VERSION']

end

gem 'puppetlabs_spec_helper'
gem 'puppet', *location_for(ENV['PUPPET_GEM_VERSION'])
gem 'r10k', *location_for(ENV['R10K_GEM_VERSION'])

# Only explicitly specify Facter/Hiera if a version has been specified.
# Otherwise it can lead to strange bundler behavior. If you are seeing weird
# gem resolution behavior, try setting `DEBUG_RESOLVER` environment variable
# to `1` and then run bundle install.
gem 'facter', *location_for(ENV['FACTER_GEM_VERSION']) if ENV['FACTER_GEM_VERSION']
gem 'hiera', *location_for(ENV['HIERA_GEM_VERSION']) if ENV['HIERA_GEM_VERSION']
gem 'hiera-eyaml'
gem 'rspec-puppet-facts'

# Danger integration: http://danger.systems
gem 'danger'
gem 'danger-changelog'
gem 'danger-mention'

# Evaluate Gemfile.local if it exists
if File.exists? "#{__FILE__}.local"
  eval(File.read("#{__FILE__}.local"), binding)
end

# Evaluate Gemfile.puppetlint if it exists
if File.exists? "#{__FILE__}.puppetlint"
  eval(File.read("#{__FILE__}.puppetlint"), binding)
end


# Evaluate ~/.gemfile if it exists
if File.exists?(File.join(Dir.home, '.gemfile'))
  eval(File.read(File.join(Dir.home, '.gemfile')), binding)
end

