class profile::nodejs (
        String $version,
  Array[String] $npm_packages,
)
{
  class { 'nodejs':
    repo_url_suffix => $version,
  }
  $npm_packages.each |String $npm_package| {
    package { $npm_package:
    ensure   => 'present',
    provider => 'npm',
    }
  }
}

