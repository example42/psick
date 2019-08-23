class profile::nodejs (
        String $version,
  Array[String] $npm_packages,
)
{
  class { 'nodejs':
    repo_url_suffix => $version,
    nodejs_dev_package_ensure => 'present',
    npm_package_ensure        => 'present',
  }
  $npm_packages.each |String $npm_package| {
    package { $npm_package:
    ensure   => 'present',
    provider => 'npm',
    }
  }
}

