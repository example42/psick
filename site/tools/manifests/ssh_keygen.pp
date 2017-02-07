# Define: ssh_keygen
# Brutally imported and adapted from:
# https://github.com/maestrodev/puppet-ssh_keygen/blob/master/manifests/init.pp
# Full credits to the Maestro Devs
#
define tools::ssh_keygen (
  Optional[String] $user     = undef,
  Optional[String] $type     = undef,
  Optional[String] $bits     = undef,
  Optional[String] $home     = undef,
  Optional[String] $filename = undef,
  Optional[String] $comment  = undef,
  Optional[String] $options  = undef,
) {

  $user_real = $user ? {
    undef   => $name,
    default => $user,
  }

  $type_real = $type ? {
    undef   => 'rsa',
    default => $type,
  }

  $home_real = $home ? {
    undef   => $user_real ? {
      'root'  => "/${user_real}",
      default => "/home/${user_real}",
    },
    default => $home,
  }

  $filename_real = $filename ? {
    undef   => "${home_real}/.ssh/id_${type_real}",
    default => $filename,
  }

  $type_opt = " -t ${type_real}"
  if $bits { $bits_opt = " -b ${bits}" }
  $filename_opt = " -f '${filename_real}'"
  $n_passphrase_opt = " -N ''"
  if $comment { $comment_opt = " -C '${comment}'" }
  $options_opt = $options ? {
    undef   => undef,
    default => " ${options}",
  }

  exec { "ssh_keygen-${name}":
    command => "ssh-keygen${type_opt}${bits_opt}${filename_opt}${n_passphrase_opt}${comment_opt}${options_opt}",
    user    => $user_real,
    creates => $filename_real,
  }

}

