# @class jenkins
#
class profile::ssh_windows (


  String $home_dir                          = 'c:\\Users\\Administrator',

) {

  file { "${home_dir}/.ssh" :
      ensure  => directory,
  }


}
