class foreman::install_from_source {

  file{$railspath: ensure => directory}

  package{"rake": 
    name => $operatingsystem ? {
      default => "rake",
      "CentOs" => "rubygem-rake",
      "RedHat" => "rubygem-rake",
    },
    ensure => installed,
    before => Exec["db_migrate"],
  }

  package{"sqlite3-ruby": 
    name => $operatingsystem ? {
      default => "libsqlite3-ruby",
      "CentOs" => "rubygem-sqlite3-ruby",
      "RedHat" => "rubygem-sqlite3-ruby",
    },
    ensure => installed,
    before => Exec["db_migrate"],
  }
# Initial Foreman Install
  exec{"install_foreman":
    command => "wget -q http://theforeman.org/foreman-latest.tar.bz2 -O - | tar xjf -",
    cwd => $railspath,
    creates => "$foreman_dir/public",
    notify => Exec["db_migrate"],
    require => File[$foreman_dir],
  }

  exec{"db_migrate":
    command => "rake db:migrate",
    environment => "RAILS_ENV=production",
    refreshonly => true
  }

}
