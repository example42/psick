#
class psick::oracle::install::testinstance {

  psick::oracle::instance { 'test':
#    autostart => false,
    require   => CLass[$psick::oracle::prerequisites_class],
  }

}
