# This class just adds gpgkeys for elasticsearch installation.
#
class psick::elasticsearch {

  tools::gpgkey { 'RPM-GPG-KEY-elasticsearch': }

}
