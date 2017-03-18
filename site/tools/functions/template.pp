# This function takes as input the path to a erb or epp template
# and passes it to the relevant Puppet function
# It returns the interpolated content of the template to be used
# directly in cases like:
# file { '/tmp/test':
#   content => tools::template('site/test.epp'),
# }
#
# Credits to Francesco Duranti for idea and implementation
#
function tools::template(String $filename) >> String {
  $ext=$filename[-4,4]
  case $ext {
    '.erb': {
      template($filename)
    }
    '.epp': {
      epp($filename)
    }
    default: {
      file($filename)
    }
  }
}
