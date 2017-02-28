#
class profile::oracle::install::testinstance {

  profile::oracle::instance { 'test':
#    autostart => false,
    require   => CLass[$profile::oracle::prerequisites_class],
  }

}
