# Class: munin::link
#
# Extended class that provides a link to be used in auto-generated links portals based on Pupept resources
# The link define can be extended in a modular way, using different "tools" to generate links aggregators
# Example42 modules provide the psick web interface ( $link_tool = "psick" )
#
# Usage:
# Automatically included if $link=yes
# Use the variable $link_tool (can be an array) to define the linking software you want to use.
#
class munin::link {

    include munin::params

    link { "Munin":
        title       => "Munin",
        description => "Munin collector Web Frontend",
        url         => "http://${fqdn}/munin",
        host        => "${fqdn}",
        type        => "monitor",
        private     => "no",
        priority    => "10",
#        linktags    => [ "${role}" , "${stack}" ], 
        login       => "",
        password    => "",
        tool        => "${link_tool}",
        enable      => "true",
    }

}
