# This class manages the /etc/yum.repos.d/pe_repo.repo file
#
# @param ensure If to add or remove the pe_repo.repo file
#
class profile::pe_repo (
  Enum['present','absent'] $ensure = 'present',
) {
  file { '/etc/yum.repos.d/pe_repo.repo':
    ensure => $ensure,
    source => 'puppet:///modules/profile/pe_repo/pe_repo.repo',
  }
}
