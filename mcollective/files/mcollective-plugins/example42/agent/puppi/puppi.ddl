metadata    :name        => "SimpleRPC Agent For PUPPI Commands",
            :description => "Agent to query PUPPI commands via MCollective", 
            :author      => "Al @ Lab42 - Cloned from R.I.Pienaar nrpe agent",
            :license     => "Apache License 2.0",
            :version     => "1.2",
            :url         => "http://www.example42.com/",
            :timeout     => 5


action "runcommand", :description => "Run a PUPPI command" do
    input :command, 
          :prompt      => "Command",
          :description => "PUPPI command to run",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9_-]+$',
          :optional    => false,
          :maxlength   => 50

    output :output,
	  :description => "Output from the Puppi run",
          :display_as  => "Output"

    output :exitcode,
          :description  => "Exit Code from the Puppi run",
          :display_as => "Exit Code"

    output :perfdata,
          :description  => "Performance Data from the Puppi run",
          :display_as => "Performance Data"
end

