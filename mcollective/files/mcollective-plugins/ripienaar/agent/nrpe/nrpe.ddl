metadata    :name        => "SimpleRPC Agent For NRPE Commands",
            :description => "Agent to query NRPE commands via MCollective", 
            :author      => "R.I.Pienaar",
            :license     => "Apache License 2.0",
            :version     => "1.2",
            :url         => "http://mcollective-plugins.googlecode.com/",
            :timeout     => 5


action "runcommand", :description => "Run a NRPE command" do
    input :command, 
          :prompt      => "Command",
          :description => "NRPE command to run",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9_-]+$',
          :optional    => false,
          :maxlength   => 50

    output :output,
	  :description => "Output from the Nagios plugin",
          :display_as  => "Output"

    output :exitcode,
          :description  => "Exit Code from the Nagios plugin",
          :display_as => "Exit Code"

    output :perfdata,
          :description  => "Performance Data from the Nagios plugin",
          :display_as => "Performance Data"
end

