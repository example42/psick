class site::logs {

  tp::install3 { 'logrotate': }
  # tp::install3 { 'rsyslog': }
  
  # Test separate data module
  # tp::install3 { 'rsyslog': data_module => 'tinydata' }

}
