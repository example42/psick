# This class installs the GPG keys used in the MariaDB packages
#
class profile::mariadb {

  tools::gpgkey { 'RPM-GPG-KEY-MariaDB': }

}
