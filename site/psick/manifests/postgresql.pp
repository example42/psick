# This class installs the RPM GPG key used for Postgresql packages
#
class psick::postgresql {

  tools::gpgkey { 'RPM-GPG-KEY-PGDG-9': }

}
