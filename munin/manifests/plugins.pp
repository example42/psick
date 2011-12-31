# class munin::plugins
# 
# This class selects and installs custom extra munin-plugins
# 
# Usage:
# include munin::plugins
#
class munin::plugins {

    # Filemgr plugin
    munin::plugin { "apache_activity": } 
    munin::plugin { "lighttpd": } 
#    munin::plugin { "bind97_": } 
    # munin::plugin { "apache_activity": enable => "no" } 

}
