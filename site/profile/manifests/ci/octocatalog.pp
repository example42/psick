# This class installs and configures via tp the octocatalog-diff tool, used to
# compare Puppet catalogs from different sources
#
# @param ensure Define if to install (present), remote (absent) or the version
#               of the octocatalog-diff gem
# @param auto_prerequisites Define id to automatically install the prerequisites
#                           needed by octocatalog-diff
# @param template The path of the erb template (as used in template()) to use
#                 as content for the octocatalog-diff configuration file
# @param options An open hash of options you can use in your template. Note that
#                this hash is merged with an hash of default options provided in
#                the class
# @param git_repo The url of a git repo to clone locally, in the git_repo_dir.
#                 You ay not need it in CI pipelines where git operations are
#                 automatically done
# @param git_repo_dir The path of the directory where to clone the git_repo
# @param run_as_user The user octocatalog-diff is supposed to be executed as
#
class profile::ci::octocatalog (
  String           $ensure             = 'present',
  Boolean          $auto_prerequisites = true,
  Optional[String] $template           = undef,
  Hash             $options            = { },
  Optional[String] $git_repo           = undef,
  String           $git_repo_dir       = '/srv/control-repo',
  String           $run_as_user        = 'root', # In CI setups set this to the CI user
) {

  if $run_as_user =='root' {
    $private_key_path = "/etc/puppetlabs/puppet/ssl/private_keys/${trusted['certname']}.pem"
  } else {
    $private_key_path = "/home/${run_as_user}/${trusted['certname']}.pem"
    file { $private_key_path:
      ensure => present,
      owner  => $run_as_user,
      group  => $run_as_user,
      mode   => '0400',
      source => "file:///etc/puppetlabs/puppet/ssl/private_keys/${trusted['certname']}.pem",
    }
  }
  $options_default = {
    'hiera_config' => 'hiera.yaml',
    'hiera_path' => 'hieradata',
    'puppetdb_url' => 'https://localhost:8081',
    'puppetdb_ssl_ca' => '/etc/puppetlabs/puppet/ssl/certs/ca.pem',
    'puppetdb_ssl_client_key_path' => $private_key_path,
    'puppetdb_ssl_client_cert_path' => "/etc/puppetlabs/puppet/ssl/certs/${trusted['certname']}.pem",
    'storeconfigs' => false,
    'bootstrap_script' => 'bin/puppet_install_puppetfile.sh',
    'puppet_binary' => '/opt/puppetlabs/puppet/bin/puppet',
    'from_env' => 'origin/production',
    'header' => ':default',
    'cached_master_dir' => "File.join(ENV['HOME'], '.octocatalog-diff-cache')",
    'safe_to_delete_cached_master_dir' => 'settings[:cached_master_dir]',
    'basedir' => 'Dir.pwd',
  }
  $octocatalog_options = $options_default + $options
  ::tp::install { 'octocatalog-diff' :
    ensure             => $ensure,
    auto_prerequisites => true,
  }

  if $template {
    ::tp::conf { 'octocatalog-diff':
      ensure       => $ensure,
      template     => $template,
      options_hash => $octocatalog_options,
    }
  }

  if $git_repo {
    ::tp::dir { 'octocatalog-diff::git_repo':
      ensure  => $ensure,
      source  => $git_repo,
      path    => $git_repo_dir,
      vcsrepo => 'git',
    }
  }

}
