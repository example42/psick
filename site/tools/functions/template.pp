function tools::template(Optional[String] $filename, Hash $parameters = {}) >> String {
  if $filename and $filename !='' {
    $ext=$filename[-4,4]
    case $ext {
      '.epp': {
        epp($filename,$parameters)
      }
      '.erb': {
        template($filename)
      }
      default: {
        file($filename)
      }
    }
  } else {
    ''
  }
}

