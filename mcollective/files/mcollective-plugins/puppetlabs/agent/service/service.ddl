metadata    :name        => "SimpleRPC Service Agent",
            :description => "Agent to manage services", 
            :author      => "R.I.Pienaar",
            :license     => "GPLv2",
            :version     => "1.2",
            :url         => "http://mcollective-plugins.googlecode.com/",
            :timeout     => 60

action "status", :description => "Gets the status of a service" do
    display :always

    input :service, 
          :prompt      => "Service Name",
          :description => "The service to get the status for",
          :type        => :string,
          :validation  => '^[a-zA-Z\-_\d]+$',
          :optional    => false,
          :maxlength   => 30

    output "status",
          :description => "The status of service",
          :display_as  => "Service Status"
end

["stop", "start", "restart"].each do |act|
    action act, :description => "#{act.capitalize} a service" do
        display :failed
    
        input :service, 
              :prompt      => "Service Name",
              :description => "The service to #{act}",
              :type        => :string,
              :validation  => '^[a-zA-Z\-_\d]+$',
              :optional    => false,
              :maxlength   => 30
    
        output "status",
              :description => "The status of service after #{act}",
              :display_as  => "Service Status"
    end
end
