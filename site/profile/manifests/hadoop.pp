# This class installs the GPG key used by Hadoop repository
#
class profile::hadoop {

  tools::gpgkey { 'RPM-GPG-KEY-HADOOP': }

}
