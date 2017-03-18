# This class just adds gpgkeys for elasticsearch installation.
#
class profile::elasticsearch {

  tools::gpgkey { 'RPM-GPG-KEY-elasticsearch': }

}
