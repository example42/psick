#
class profile::java (
  $openjdk_jdk_ensure = 'present',
  $openjdk_jre_ensure = 'present',
) {
  tp::install { 'openjdk-jdk':
    ensure => $openjdk_jdk_ensure,
  }
  tp::install { 'openjdk-jre':
    ensure => $openjdk_jre_ensure,
  }
}
