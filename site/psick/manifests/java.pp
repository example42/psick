# This class manages JAVA installation
# By default it installs both the OpenJDK JRE and JDK packages.
#
# @param openjdk_jdk_ensure Define if to install OpenJDK JDK
# @param openjdk_jre_ensure Define if to install OpenJDK JRE
#
class psick::java (
  Enum['present','absent'] $openjdk_jdk_ensure = 'present',
  Enum['present','absent'] $openjdk_jre_ensure = 'present',
) {
  tp::install { 'openjdk-jdk':
    ensure => $openjdk_jdk_ensure,
  }
  tp::install { 'openjdk-jre':
    ensure => $openjdk_jre_ensure,
  }
}
