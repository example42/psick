
class hardening::services {

        service {
                "anacron":   enable    => "false", ensure    => "stopped";
                "autofs":   enable    => "false", ensure    => "stopped";
                "avahi-daemon":   enable    => "false", ensure    => "stopped";
                "avahi-dnsconfd":   enable    => "false", ensure    => "stopped";
                "gpm":   enable    => "false", ensure    => "stopped";
                "netfs":   enable    => "false", ensure    => "stopped";
                "nfs":   enable    => "false", ensure    => "stopped";
                "nfslock":   enable    => "false", ensure    => "stopped";
                "portmap":   enable    => "false", ensure    => "stopped";
                "rpcgssd":   enable    => "false", ensure    => "stopped";
                "rpcsvcgssd":   enable    => "false", ensure    => "stopped";
                "rpcidmapd":   enable    => "false", ensure    => "stopped";
                "ypbind":   enable    => "false", ensure    => "stopped";
        }

}

