# Class profile::puppet::foss_master
#
# this class bootstraps a Puppet Open Source master
#
# @param r10k_remote_repo (default: '') specify the git URL to your control repo
# @param manage_puppetdb_repo (default: true)
# @param enable_puppetdb (default true)
#
# example usage:
#   contain profile::puppet::foss_master
#
#   class { 'profile::puppet::foss_master':
#     r10k_repmote_repo = 'https://github.com/example42/psick.git'
#   }
#
# TODO:
#
# - make all default repos optional
# - ensure DNS alt names are possible for puppet server
# - separate puppetdb host
# - separate postgresql host
# - allow multi master setup
# - allow multiple control-repos
#
class profile::puppet::foss_master (
  Optional[String]  $r10k_remote_repo     = undef,
  Boolean           $manage_puppetdb_repo = true,
  Boolean           $enable_puppetdb      = true,
){
  contain ::profile::git
  contain puppetserver

  if $r10k_remote_repo {
    class { 'r10k':
      remote   => $r10k_remote_repo,
      provider => 'puppet_gem',
      require  => Class['profile::git'],
    }
    class {'r10k::webhook::config':
      enable_ssl      => false,
      use_mcollective => false,
      require         => Class['r10k'],
    }
    class {'r10k::webhook':
      use_mcollective => false,
      user            => 'root',
      group           => '0',
      require         => Class['r10k::webhook::config'],
    }
  }
  if $enable_puppetdb {
    # Bug in puppetlabs-postgresql in combination with PuppetDB module
    # postgresql-contrib package provides the pg_trgm extension
    package { 'postgresql94-contrib':
      ensure => present,
    }
    class { 'puppetdb':
      manage_firewall     => false,
      manage_package_repo => $manage_puppetdb_repo,
      ssl_protocols       => 'TLSv1.2',
      postgres_version    => '9.4',
    }
    # Workflow: create puppetserver ssl ca and certificates
    # needed for puppetdb ssl setup
    exec { '/sbin/service puppetserver start':
      command => 'puppet service puppetserver ensure=running',
      path    => '/opt/puppetlabs/bin:/usr/bin:/bin:/usr/sbin:/sbin'
      creates => '/etc/puppetlabs/puppet/ssl/certs/ca.pem',
      require => Package['puppetserver'],
    }
    class { 'puppetdb::master::config':
      manage_report_processor => true,
      enable_reports          => true,
      restart_puppet          => false,
      before                  => Service['puppetserver'],
    }
    # Bug: running puppetserver as root creates certificates as root
    # puppetserver on standard run needs certificates to be owned by puppet user
    file { '/etc/puppetlabs/puppet/ssl':
      ensure  => directory,
      owner   => 'puppet',
      group   => 'puppet',
      recurse => true,
      require => [
        Class['puppetdb'],
        CLass['puppetdb::master::config'],
      ],
      notify  => Service['puppetserver'],
    }
  }
}

