class role::ssh (

  Variant[Boolean,String]    $ensure     = 'present',
  Enum['psick']              $module     = 'psick',

  Optional[String] $ssh_private_key_content = undef,
  Optional[String] $ssh_public_key_content  = undef,
  Optional[String] $ssh_private_key_source  = undef,
  Optional[String] $ssh_public_key_source   = undef,
  Optional[String] $ssh_knownhost_content   = undef,
  Optional[String] $ssh_knownhost_source    = undef,

  Boolean $ssh_keys_generate                = false,
  String $home_dir                          = 'c:\\Users\\Administrator',
  String $ssh_key_name                      = 'id_rsa',

) {

  # SSH keys management
  if $ssh_private_key_content
  or $ssh_public_key_content
  or $ssh_private_key_source
  or $ssh_public_key_source {
    $dir_ensure = ::tp::ensure2dir($ensure)
    file { "${home_dir}/.ssh" :
      ensure  => $dir_ensure,
    }
  }

  if $ssh_private_key_content or $ssh_private_key_source {
    file { "${home_dir}/.ssh/${ssh_key_name}" :
      ensure  => $ensure,
      content => $ssh_private_key_content,
      source  => $ssh_private_key_source,
    }
  }

  if ssh_knownhost_content or $ssh_knownhost_source {
    file { "${home_dir}/.ssh/known_hosts" :
      ensure  => $ensure,
      content => $ssh_knownhost_content,
      source  => $ssh_knownhost_source,
    }
  }

  if $ssh_public_key_content or $ssh_public_key_source {
    file { "${home_dir}/.ssh/${ssh_key_name}.pub" :
      ensure  => $ensure,
      content => $ssh_public_key_content,
      source  => $ssh_public_key_source,
    }
  }


}
