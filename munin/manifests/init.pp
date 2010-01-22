#
# munin module
# munin.pp - everything a sitewide munin installation needs
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# 
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#
# the port is a parameter so vservers can share 
# IP addresses and still be happy

class munin {
    module_dir { [ "munin", "munin/nodes", "munin/plugins" ]: }
}
