# Class: puppet::ruby
#
# Installs ruby packages useful for Puppet
#
# Usage:
# include puppet::ruby
#

class puppet::ruby {

  package{"rubygems":
    name => $operatingsystem ? {
      default => "rubygems",
    },
    ensure => installed,
  }


  package{"rake":
    name => $operatingsystem ? {
      default => "rake",
      "CentOs" => "rubygem-rake",
      "RedHat" => "rubygem-rake",
    },
    ensure => installed,
  }

  package{"sqlite3-ruby":
    name => $operatingsystem ? {
      default => "libsqlite3-ruby",
      "CentOs" => "rubygem-sqlite3-ruby",
      "RedHat" => "rubygem-sqlite3-ruby",
    },
    ensure => installed,
  }

}

