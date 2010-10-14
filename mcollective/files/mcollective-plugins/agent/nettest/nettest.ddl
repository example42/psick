metadata    :name        => "Ping",
            :description => "Agent to do network tests from a mcollective host",
            :author      => "Dean Smith <dean@zelotus.com>",
            :license     => "BSD",
            :version     => "1.0",
            :url         => "http://github.com/deasmi",
            :timeout     => 60

action "ping", :description => "Returns rrt of ping to host" do
    display :always

    input :fqdn,
        :prompt => "FQDN",
        :description => "The fully qualified domain name to ping",
        :type => :string,
        :validation => '^.+$',
        :optional => false,
        :maxlength => 80
  
    output :rtt,
        :description => "The round trip time in ms",
        :display_as=>"RTT"

end
		
action "connect", :description => "Check connectivity of remote server on port" do
	display :always

    input :fqdn,
        :prompt => "FQDN",
        :description => "The fully qualified domain name to ping",
        :validation => '^.+$',
        :type => :string,
        :optional => false,
        :maxlength => 80

    input :port,
	:prompt => "Port",
	:description => "The port to connect on",
        :validation => '^[0-9]+$',
	:type => :string,
        :optional => false
	
    output :connect,
        :description => "Can we connect",
        :display_as=>"connected"

end