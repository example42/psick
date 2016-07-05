class profile::git (
  $ensure = 'present',
) {
  tp::install { 'git':
    ensure => $ensure,
  }
}
