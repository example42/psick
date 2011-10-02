class apt::unattended-upgrade-automatic {
  package {"unattended-upgrades":
    ensure => present,
  }
  
  apt::conf{"99unattended-upgrade":
    ensure  => present,
    content => "APT::Periodic::Unattended-Upgrade \"1\";\n",
  }

  case $lsbdistid {
    'Debian': {
      apt::conf{'50unattended-upgrades':
        ensure  => present,
        content => template("apt/unattended-upgrades.${lsbdistcodename}.erb"),
      }
    }
    'Ubuntu': {
      apt::conf{'50unattended-upgrades':
        ensure  => present,
        content => template("apt/unattended-upgrades.${lsbdistid}.erb"),
      }
    }
  }

}
