# This class creates directories for Oracle databases
#
# @param base_dir Base directory where to create all the oracle dirs
# @param dirs An hash of applications and db names for which dirs
#             should be created
# @param suffixes An array of suffixes, for each on a directory is created
#                 merging application namd and suffix
#               
# @example
# Data like this:
#  profile::oracle::prerequisites::dirs_class: 'profile::oracle::prerequisites::dirs'
#  profile::oracle::prerequisites::dirs::dirs:
#    app1:
#      - 'db1'
#      - 'db2'
#    app2:
#      - 'db1'
#  profile::oracle::prerequisites::dirs::suffixes:
#    - '_DATA'
#    - '_FRA'
#
# Will create these directories:
# /data/oracle/app1_DATA/db1
# /data/oracle/app1_DATA/db2
# /data/oracle/app1_FRA/db1
# /data/oracle/app1_FRA/db2
# /data/oracle/app2_DATA/db1
# /data/oracle/app2_FRA/db1

class profile::oracle::prerequisites::dirs (

  String $base_dir = '/data/oracle',
  Hash $dirs       = {},
  Array $suffixes  = [ '' ],
  String $owner    = 'oracle',
  String $group    = 'dba',

) {

  if $dirs != {} {
    tools::create_dir { $base_dir:
      owner => $owner,
      group => $group,
    }

    $dirs.each | $apps , $dbs | {
      $suffixes.each | $suffix | {
        file { "${base_dir}/${apps}${suffix}":
          ensure  => directory,
          owner   => $owner,
          group   => $group,
          require => Tools::Create_dir[$base_dir],
        }
        $dbs.each | $db | {
          file { "${base_dir}/${apps}${suffix}/${db}":
            ensure  => directory,
            owner   => $owner,
            group   => $group,
            require => Tools::Create_dir[$base_dir],
          }
        }
      }
    }
  }
}
