# Install'em all

tp::stdmod { 'apache': }
tp::stdmod { 'autofs': }
tp::stdmod { 'clvm': }
tp::stdmod { 'fail2ban': }
tp::stdmod { 'freeradius': }
tp::stdmod { 'heartbeat': }
tp::stdmod { 'libvirt': }
# tp::stdmod { 'lighttpd': }
tp::stdmod { 'mailx': }
# tp::stdmod { 'msmtp': }
# tp::stdmod { 'openntpd': }
tp::stdmod { 'openssh': }
tp::stdmod { 'redis': }
tp::stdmod { 'samba': }
# tp::stdmod { 'sysklogd': }
# tp::stdmod { 'tftpd': }
tp::stdmod { 'xinetd': }


# Tests
/*
tp::stdmod { 'apache':
  files  => {
    '/tmp/apache.conf' => { content => 'test' } ,
  },
}

tp::conf { 'apache::test':
  content => test,
}
tp::conf { 'openssh::test':
  content => test,
}
tp::conf { 'redis::test':
  content => test,
}
*/
