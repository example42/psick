# This class manages backup.
#
# @example Include the legato class for backup:
#   psick::backup::legato_class: '::psick::backup::legato'
#
# @params legato_class Name of the class that manages Legato Installation
#
class psick::backup (
  String $legato_class   = '',
) {

  if $legato_class != '' {
    include $legato_class
  }

}
