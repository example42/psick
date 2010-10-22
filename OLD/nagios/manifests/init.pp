#
# nagios module
# nagios.pp - everything nagios related
#
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class nagios {
    case $nagios_httpd {
    'absent': { }
    'lighttpd': { include lighttpd }
    'apache': { include apache }
    default: { include apache }
    }
    case $operatingsystem {
    'centos': {
        $nagios_cfgdir = '/etc/nagios'
        include nagios::centos
    }
    'debian': {
        $nagios_cfgdir = '/etc/nagios3'
        include nagios::debian
    }
    default: { fail("No such operatingsystem: $operatingsystem yet defined") }
    }
}
