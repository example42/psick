class example42::role::allabsent {
#  include openntpd::absent
  include nrpe::absent
  include tomcat::absent
  include nagios::absent
  include powerdns::absent
  include activemq::absent
#  include dashboard::absent
  include samba::absent
  include munin::absent
  include ntp::absent
  include squid::absent
  include bind::absent
  include dhcpd::absent
#  include apache::absent
  include vagrant::absent
  include lighttpd::absent
  include rsyslog::absent
  include iptables::absent
  include exim::absent
  # include clamav::absent
  include puppet::absent
  include drupal::absent
  include vmware::absent
#  include mcollective::absent
  include collectd::absent
  include virtualbox::absent
  include openssh::absent
  include openldap::absent
#  include postgresql::absent
  include openvpn::absent
  include monit::absent
  include varnish::absent
  include autofs::absent
  include postfix::absent
  include mysql::absent
  include snmpd::absent
  include sysklogd::absent
  include vsftpd::absent
  include dovecot::absent
  include rsync::absent
  include nfs::absent
  include foo::absent
#  include jboss::absent
  include cobbler::absent
  include portmap::absent
}
