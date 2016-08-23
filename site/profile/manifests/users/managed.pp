# Copied from example42 user::managed
# sshkey:           have to be handed over as the classname
#                   containing the ssh_keys
# password:         the password in cleartext or as crypted string
#                   which should be set. Default: absent -> no password is set.
#                   To create an encrypted password, you can use:
#                   /usr/bin/mkpasswd -H md5 --salt=$salt $password , where $salt is 8 bytes long
#                   Note: On OpenBSD systems we can only manage crypted passwords.
#                         Therefor the password_crypted option doesn't have any effect.
#                         You'll find a python script in ${module}/password/openbsd/genpwd.py
#                         Which will help you to create such a password
# password_crypted: if the supplied password is crypted or not.
#                   Default: true
#                   Note: If you'd like to use unencrypted passwords, you have to set a variable
#                         $password_salt to an 8 character long salt, being used for the password.
# gid:              define the gid of the group
#                   absent: let the system take a gid
#                   uid: take the same as the uid has if it isn't absent (*default*)
#                   <value>: take this gid
# manage_group:     Wether we should add a group with the same name as well, this works only
#                   if you supply a uid.
#                   Default: true
# sshkey_content:   supply ssh key via 'key', 'comment' and 'type'
# sshkeys_content:  supply ssh keys via an array of 'key', 'comment' and 'type'
define profile::users::managed(
  String $ensure             = present,
  String $name_comment       = 'absent',
  String $uid                = 'absent',
  String $gid                = 'uid',
  $groups             = [],
  $manage_group       = true,
  $membership         = 'minimum',
  $homedir            = 'absent',
  $managehome         = true,
  $homedir_mode       = '0750',
  $sshkey             = 'absent',
  $sshkey_source      = '',
  $bashprofile_source = '',
  $known_hosts_source = '',
  $password           = 'absent',
  $password_crypted   = true,
  $password_salt      = '',
  $shell              = 'absent',
  $id_rsa_source      = '',
  $id_rsa_pub_source  = '',
  $tag                = undef,
  $sshkey_content     = {},
  $sshkeys_content    = []
){

  $real_homedir = $homedir ? {
    'absent' => "/home/${name}",
    default => $homedir
  }

  $real_name_comment = $name_comment ? {
    'absent' => $name,
    default => $name_comment,
  }

  $real_shell = '/bin/bash'

  $dir_ensure = $ensure ? {
    'present' => 'directory',
    'absent'  => 'absent',
  }

  user { $name:
    ensure     => $ensure,
    allowdupe  => false,
    comment    => $real_name_comment,
    home       => $real_homedir,
    managehome => $managehome,
    shell      => $real_shell,
    groups     => $groups,
    membership => $membership,
    tag        => $tag,
  }

  # Manage authorized keys if $sshkey_source exists

  if $sshkey_source != ''
  or $id_rsa_source != ''
  or $id_rsa_pub_source != ''
  or $known_hosts_source != ''
  or !empty($sshkey_content)
  or !empty($sshkeys_content) {
    file { "${real_homedir}_ssh":
      ensure  => $dir_ensure,
      path    => "${real_homedir}/.ssh",
      require => File[$real_homedir],
      owner   => $name,
      group   => $name,
      mode    => $homedir_mode,
    }
  }

  if $sshkey_source != '' {
    file { "${real_homedir}_ssh_keys":
      ensure  => $ensure,
      path    => "${real_homedir}/.ssh/authorized_keys2",
      require => File[$real_homedir],
      owner   => $name,
      group   => $name,
      mode    => '0600',
      source  => "puppet:///modules/${sshkey_source}",
    }
  }

  $sshkey_defaults = {
    ensure => present,
    user   => $name,
    'type'   => 'ssh-rsa'
  }

  if !empty($sshkey_content) {
    ssh_authorized_key { $sshkey_content['comment']:
      ensure => present,
      user   => $name,
      type   => $sshkey_content['type'],
      key    => $sshkey_content['key'],
    }
  }

  if !empty($sshkeys_content) {
    create_resources(ssh_authorized_key, $sshkeys_content, $sshkey_defaults)
  }

  if $id_rsa_source != '' {
    file { "${real_homedir}_ssh_id_rsa":
      ensure  => $ensure,
      path    => "${real_homedir}/.ssh/id_rsa",
      require => File[$real_homedir],
      owner   => $name,
      group   => $name,
      mode    => '0600',
      source  => "puppet:///modules/${id_rsa_source}",
    }
  }

  if $id_rsa_pub_source != '' {
    file { "${real_homedir}_ssh_id_rsa_pub":
      ensure  => $ensure,
      path    => "${real_homedir}/.ssh/id_rsa.pub",
      require => File[$real_homedir],
      owner   => $name,
      group   => $name,
      mode    => '0644',
      source  => "puppet:///modules/${id_rsa_pub_source}",
    }
  }


  if $known_hosts_source != '' {
    file { "${real_homedir}_known_hosts":
      ensure  => $ensure,
      path    => "${real_homedir}/.ssh/known_hosts",
      require => File[$real_homedir],
      owner   => $name,
      group   => $name,
      mode    => '0600',
      source  => "puppet:///modules/${known_hosts_source}",
    }
  }

  if $bashprofile_source != '' {
    file { "${real_homedir}/.bash_profile":
      ensure  => $ensure,
      path    => "${real_homedir}/.bash_profile",
      require => File[$real_homedir],
      owner   => $name,
      group   => $name,
      mode    => '0644',
      source  => "puppet:///modules/${bashprofile_source}",
    }
  }

  if $managehome {
    file{$real_homedir: }
    if $ensure == 'absent' {
      File[$real_homedir]{
        ensure  => absent,
        purge   => true,
        force   => true,
        recurse => true,
      }
    } else {
      File[$real_homedir]{
        ensure  => directory,
        require => User[$name],
        owner   => $name, mode => $homedir_mode,
      }
      case $gid {
        'absent','uid': {
          File[$real_homedir]{
            group => $name,
          }
        }
        default: {
          File[$real_homedir]{
            group => $gid,
          }
        }
      }
    }
  }

  if $uid != 'absent' {
    User[$name]{
      uid => $uid,
    }
  }

  if $gid != 'absent' {
    if $gid == 'uid' {
      if $uid != 'absent' {
        $real_gid = $uid
      }
    } else {
      $real_gid = $gid
    }
    if $real_gid {
      User[$name]{
        gid => $real_gid,
      }
    }
  }

  if $name != 'root' {
    if $uid == 'absent' {
      if $manage_group and ($ensure == 'absent') {
        group{$name:
        ensure => absent,
        }
        case $::operatingsystem {
        OpenBSD: {
          Group[$name]{
          before => User[$name],
          }
        }
        default: {
          Group[$name]{
          require => User[$name],
          }
        }
        }
      }
    } else {
      if $manage_group {
        group { $name:
          ensure    => $ensure,
          allowdupe => false,
        }
        if $real_gid {
          Group[$name]{
            gid => $real_gid,
          }
        }
        if $ensure == 'absent' {
          case $::operatingsystem {
          OpenBSD: {
            Group[$name]{
            before => User[$name],
            }
          }
          default: {
            Group[$name]{
            require => User[$name],
            }
          }
          }
        } else {
          Group[$name]{
          before => User[$name],
          }
        }
      }
    }
  }
  case $ensure {
    present: {
      if $sshkey != 'absent' {
        User[$name]{
          before => Class[$sshkey],
        }
        include $sshkey
      }

      if $password != 'absent' {
        case $::operatingsystem {
          'openbsd': {
            exec { "setpass ${name}":
              unless  => "grep -q '^${name}:${password}:' /etc/master.passwd",
              command => "usermod -p '${password}' ${name}",
              require => User[$name],
            }
          }
          default: {
            # require ruby::shadow #
            if $password_crypted {
              $real_password = $password
            } else {
              if $password_salt != '' {
                $real_password = mkpasswd($password,$password_salt)
              } else {
                fail('To use unencrypted passwords you have to define a variable \$password_salt to an 8 character salt for passwords!')
              }
            }
            User[$name]{
              password => $real_password,
            }
          }
        }
      }
    }
  }
}

