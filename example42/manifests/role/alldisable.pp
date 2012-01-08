class example42::role::alldisable {
#  include openntpd::disable
  include nrpe::disable
  include tomcat::disable
  include nagios::disable
  include powerdns::disable
  include activemq::disable
#  include dashboard::disable
  include samba::disable
  include munin::disable
  include ntp::disable
  include squid::disable
  include bind::disable
  include dhcpd::disable
#  include apache::disable
  include vagrant::disable
  include lighttpd::disable
  include rsyslog::disable
  include iptables::disable
  include exim::disable
  # include clamav::disable
  include puppet::disable
  include drupal::disable
  include vmware::disable
#  include mcollective::disable
  include collectd::disable
  include virtualbox::disable
  include openssh::disable
  include openldap::disable
#  include postgresql::disable
  include openvpn::disable
  include monit::disable
  include varnish::disable
  include autofs::disable
  include postfix::disable
  include mysql::disable
  include snmpd::disable
  include sysklogd::disable
  include vsftpd::disable
  include dovecot::disable
  include rsync::disable
  include nfs::disable
  include foo::disable
#  include jboss::disable
  include cobbler::disable
  include portmap::disable
}
