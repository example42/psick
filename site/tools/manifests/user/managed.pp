# Copied from example42 user::managed
# sshkey:           have to be handed over as the classname
#                   containing the ssh_keys
# password:         the password in cleartext or as crypted string which
#                   should be set. Default: absent -> no password is set.
#                   To create an encrypted password, you can use:
#                   /usr/bin/mkpasswd -H md5 --salt=$salt $password ,
#                   where $salt is 8 bytes long
#                   Note: On OpenBSD systems we can only manage crypted
#                         passwords. Therefor the password_crypted
#                         option doesn't have any effect.
# password_crypted: if the supplied password is crypted or not.
#                   Default: true
#                   Note: If you'd like to use unencrypted passwords,
#                         you have to set a variable $password_salt to
#                         an 8 character long salt used for the password.
# gid:              define the gid of the group
#                   absent: let the system take a gid
#                   uid: (*default*) take the same as the uid if present
#                   <value>: take this gid
# manage_group:     Wether we should add a group with the same name as
#                   well, this works only if you supply a uid.
#                   Default: true
# sshkey_content:   supply ssh key via 'key', 'comment' and 'type'
# sshkeys_content:  supply ssh keys via an array of 'key', 'comment' and 'type'
define tools::user::managed(
  String $ensure       = present,
  String $comment       = '',
  String $uid          = 'absent',
  String $gid          = 'uid',
  Array $groups              = [],
  Boolean $manage_group        = true,
  String $membership          = 'minimum',
  $homedir             = 'absent',
  $managehome          = true,
  $homedir_mode        = '0750',
  $sshkey              = 'absent',
  $authorized_keys_source       = '',
  $bashprofile_source  = '',
  $known_hosts_source  = '',
  $password            = 'absent',
  $password_crypted    = true,
  $password_salt       = '',
  $shell               = '/bin/bash',
  $id_rsa_source       = '',
  $id_rsa_pub_source   = '',
  $sshkey_content      = {},
  $sshkeys_content     = [],
  $generate_ssh_keypair = false,
){

  $real_homedir = $homedir ? {
    'absent' => $name ? {
      'root'  => '/root',
      default => "/home/${name}",
    },
    default  => $homedir
  }

  $real_comment = $comment ? {
    ''      => $name,
    default => $comment,
  }

  $dir_ensure = $ensure ? {
    'present' => 'directory',
    'absent'  => 'absent',
  }

  File {
    ensure  => $ensure,
    owner   => $name,
    group   => $name,
  }

  user { $name:
    ensure     => $ensure,
    allowdupe  => false,
    comment    => $real_comment,
    home       => $real_homedir,
    managehome => $managehome,
    shell      => $shell,
    groups     => $groups,
    membership => $membership,
  }

  # Manage authorized keys if $authorized_keys_source exists
  if $authorized_keys_source != ''
  or $id_rsa_source != ''
  or $id_rsa_pub_source != ''
  or $known_hosts_source != ''
  or !empty($sshkey_content)
  or !empty($sshkeys_content) {
    file { "${real_homedir}_ssh":
      ensure => $dir_ensure,
      path   => "${real_homedir}/.ssh",
      mode   => $homedir_mode,
    }
  }

  if $authorized_keys_source != '' {
    file { "${real_homedir}/.ssh/authorized_keys2":
      mode   => '0600',
      source => $authorized_keys_source,
    }
  }

  $sshkey_defaults = {
    ensure => present,
    user   => $name,
    'type' => 'ssh-rsa',
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

  if $generate_ssh_keypair {
    if $id_rsa_source == '' and $id_rsa_pub_source == '' {
      tools::ssh_keygen { $name:
        comment => $real_comment,
        require => User[$name],
      }
    } else {
      fail('You can set both generate_ssh_keypair to true and any of id_rsa_source or id_rsa_source')
    }
  }

  if $id_rsa_source != '' {
    file { "${real_homedir}/.ssh/id_rsa":
      mode   => '0600',
      source => $id_rsa_source,
    }
  }

  if $id_rsa_pub_source != '' {
    file { "${real_homedir}/.ssh/id_rsa.pub":
      mode   => '0644',
      source => $id_rsa_pub_source,
    }
  }


  if $known_hosts_source != '' {
    file { "${real_homedir}/.ssh/known_hosts":
      mode   => '0600',
      source => $known_hosts_source,
    }
  }

  if $bashprofile_source != '' {
    file { "${real_homedir}/.bash_profile":
      mode   => '0644',
      source => $bashprofile_source,
    }
  }

  if $managehome {
    file{ $real_homedir: }
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
        owner   => $name,
        mode    => $homedir_mode,
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
      } else {
        #lint:ignore:undef_in_function_assignment
        $real_gid = undef
        #lint:endignore
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
        'OpenBSD': {
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
          'OpenBSD': {
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
  if $ensure == 'present' {
    if $sshkey != 'absent' {
      User[$name]{
        before => Class[$sshkey],
      }
      include $sshkey
    }

    if $password != 'absent' {
      case $::operatingsystem {
        'OpenBSD': {
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

