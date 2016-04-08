# Extra modules needed for Vagrant test environment. Install them with:
# librarian-puppet install --puppetfile Puppetfile --path modules/public

forge "http://forge.puppetlabs.com"

## This is Tiny Puppet and tinydata. Both required.
mod 'example42/tp',
  :git => 'git@github.com:example42/puppet-tp'
mod 'example42/tinydata',
  :git => 'git@github.com:example42/tinydata'

## Stdlib is a required dependency of tp
mod 'puppetlabs/stdlib',
  :git => 'git@github.com:puppetlabs/puppetlabs-stdlib.git'

## The following are optional dependencies (needed only if you use some features)
mod 'puppetlabs/vcsrepo',
  :git => 'git@github.com:puppetlabs/puppetlabs-vcsrepo.git'
mod 'puppetlabs/concat',
  :git => 'git@github.com:puppetlabs/puppetlabs-concat.git'
#mod 'example42/puppi',
#  :git => 'git@github.com:example42/puppi'


# These are extra public modules used in the sample profiles of 
# the playground. They are needed only for demo purposes.
# Tp doesn't need them (but can cohexist)

mod 'puppetlabs/java',
  :git => 'git@github.com:puppetlabs/puppetlabs-java.git'

mod 'example42/profile',
  :git => 'git@github.com:example42/tp-profiles.git'
