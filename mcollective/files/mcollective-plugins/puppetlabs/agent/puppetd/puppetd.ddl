metadata    :name        => "SimpleRPC Puppet Agent",
            :description => "Agent to manage the puppet daemon",
            :author      => "R.I.Pienaar",
            :license     => "Apache License 2.0",
            :version     => "1.3",
            :url         => "http://mcollective-plugins.googlecode.com/",
            :timeout     => 20

action "enable", :description => "Enables the Puppetd" do
    output :output,
           :description => "String indicating status",
           :display_as => "Status"
end

action "disable", :description => "Disables the Puppetd" do
    output :output,
           :description => "String indicating status",
           :display_as => "Status"
end

action "runonce", :description => "Initiates a single Puppet run" do
    #input :forcerun,
    #    :prompt      => "Force puppet run",
    #    :description => "Should the puppet run happen immediately",
    #    :type        => :string,
    #    :validation  => '^.+$',
    #    :optional    => true,
    #    :maxlength   => 5
    
    output :output,
           :description => "Output from puppetd",
           :display_as => "Output"
end

action "status", :description => "Status of the Puppet daemon" do
    display :always
    
    output :enabled,
           :description => "Is the agent enabled",
           :display_as => "Enabled"
    
    output :running,
           :description => "Is the agent running",
           :display_as => "Running"
    
    output :lastrun,
           :description => "When last did the agent run",
           :display_as => "Last Run"
    
    output :output,
           :description => "String displaying agent status",
           :display_as => "Status"
end
