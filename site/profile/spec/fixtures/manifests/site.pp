# Some resource defaults for Files, Execs and Tiny Puppet
File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}
Exec {
  path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
}
Tp::Install {
  test_enable  => hiera('tp::test_enable', false),
  puppi_enable => hiera('tp::puppi_enable', false),
  debug => hiera('tp::debug', false),
  data_module  => hiera('tp::data_module', 'tinydata'),
}
Tp::Conf {
  config_file_notify => hiera('tp::config_file_notify', true),
  config_file_require => hiera('tp::config_file_require', true),
  debug => hiera('tp::debug', false),
  data_module  => hiera('tp::data_module', 'tinydata'),
}
Tp::Dir {
  config_dir_notify => hiera('tp::config_dir_notify', true),
  config_dir_require => hiera('tp::config_dir_require', true),
  debug  => hiera('tp::debug', false),
  data_module  => hiera('tp::data_module', 'tinydata'),
}

