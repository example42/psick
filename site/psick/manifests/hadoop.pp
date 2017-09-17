# This class installs the GPG key used by Hadoop repository
#
class psick::hadoop {

  tools::gpgkey { 'RPM-GPG-KEY-HADOOP': }

}
