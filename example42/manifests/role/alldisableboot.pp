class example42::role::alldisableboot {
#  include openntpd::disableboot
  include nrpe::disableboot
  include tomcat::disableboot
  include nagios::disableboot
  include powerdns::disableboot
  include activemq::disableboot
#  include dashboard::disableboot
  include samba::disableboot
  include munin::disableboot
  include ntp::disableboot
  include squid::disableboot
  include bind::disableboot
  include dhcpd::disableboot
#  include apache::disableboot
  include vagrant::disableboot
  include lighttpd::disableboot
  include rsyslog::disableboot
  include iptables::disableboot
  include exim::disableboot
  # include clamav::disableboot
  include puppet::disableboot
  include drupal::disableboot
  include vmware::disableboot
#  include mcollective::disableboot
  include collectd::disableboot
  include virtualbox::disableboot
  include openssh::disableboot
  include openldap::disableboot
#  include postgresql::disableboot
  include openvpn::disableboot
  include monit::disableboot
  include varnish::disableboot
  include autofs::disableboot
  include postfix::disableboot
  include mysql::disableboot
  include snmpd::disableboot
  include sysklogd::disableboot
  include vsftpd::disableboot
  include dovecot::disableboot
  include rsync::disableboot
  include nfs::disableboot
  include foo::disableboot
#  include jboss::disableboot
  include cobbler::disableboot
  include portmap::disableboot
}
