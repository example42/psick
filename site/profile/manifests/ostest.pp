class profile::ostest {

  # Test Settings validation
  $settings = {
    package_name => false
  }
  tp::install { 'nginx': }
  tp::conf { 'nginx':
    settings_hash => $settings
  }
  
  # Test base failures
  tp::install { 'vsftpd': }
  tp::conf3 { 'vsftpd':
    base_file => 'init',
    content   => 'test',
  }
}
