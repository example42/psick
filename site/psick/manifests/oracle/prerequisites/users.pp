# This class configures the users prerequisites for Oracle installation
#
# @param has_asm Define if the oracle server will use ASM or not.
#                Default: false. If true additional default groups are
#                created.
# @param users Hash of users to create (passed to the users resource)
#              for oracle installation and usage. Default is empty.
#              The hash is merged with the eventual set of default users.
# @param groups Hash of groups to create (passed to the groups resource)
#               for oracle installation and usage. Default is empty.
#              The hash is merged with the eventual set of default groups.
# @param use_defauls Define if to create a default set of oracle users
#                    and groups. Default is true. If false and no users or
#                    groups are defined, this class does nothing
#               
class psick::oracle::prerequisites::users (

  Boolean $has_asm                   = false,
  Hash $groups                    = {},
  Hash $users                     = {},
  Boolean $use_defaults           = true,

) {

  $default_groups = {
    oinstall => {
      gid => '700',
    },
    dba => {
      gid => '701',
    },
    oper => {
      gid => '702',
    },
    backupdba => {
      gid => '703',
    },
    dgdba => {
      gid => '704',
    },
    kmdba => {
      gid => '705',
    },
  }

  $asm_groups = $has_asm ? {
    true => {
      'asmdba' => {
        'gid' => '706',
      },
      'asmadmin' => {
        'gid' => '707',
      },
      'asmoper' => {
        'gid' => '708',
      },
    },
    false => { },
  }

  $all_groups = $use_defaults ? {
    true  => $default_groups + $asm_groups + $groups,
    false => $groups,
  }

  $all_groups.each | $k , $v | {
    group { $k:
      * => $v,
    }
  }


  $default_users = {
    gridora => {
      uid     => '700',
      gid     => '700',
      groups  => $has_asm ? {
        true  => [ 'asmdba','asmadmin','asmoper' ],
        false => [ 'dba' ],
      },
      shell   => '/bin/bash',
      home    => '/home/gridora',
      require => Group['oinstall'],
      managehome => true,
    },
    oracle => {
      uid     => '701',
      gid     => '700',
      groups  => $has_asm ? {
        true  => [ 'dba','oper','backupdba','dgdba','kmdba','asmdba' ],
        false => [ 'dba','oper','backupdba','dgdba','kmdba' ],
      },
      shell   => '/bin/bash',
      home    => '/home/gridora',
      require => Group['oinstall'],
      managehome => true,
    },
  }

  $all_users = $use_defaults ? {
    true  => $default_users + $users,
    false => $users,
  }

  $all_users.each | $k , $v | {
    user { $k:
      * => $v,
    }
  }

}
