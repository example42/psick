class profile::environment (
  String $home_dir                          = 'c:\\Users\\Administrator',
) {
  file { "${home_dir}/.ssh" :
      ensure  => directory,
  }
}
