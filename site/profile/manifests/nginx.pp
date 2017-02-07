# This class adds the RPM GSPGP key for nginx packages and installs NGINX via TP
#
# @param ensure If to install or remove NGINX
#
class profile::nginx (
  Enum['present','absent'] $ensure = present,
) {

  tools::gpgkey { 'RPM-GPG-KEY-NGINX':  ensure => $ensure }
  tp_install('nginx', { ensure => $ensure, })

}
