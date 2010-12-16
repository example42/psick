metadata    :name        => "SimpleRPC IP Tables Agent",
            :description => "An agent that manipulates a chain called 'junkfilter' with iptables",
            :author      => "R.I.Pienaar",
            :license     => "GPLv2",
            :version     => "1.2",
            :url         => "http://mcollective-plugins.googlecode.com/",
            :timeout     => 2

["block", "unblock"].each do |act|
    action act, :description => "#{act.capitalize} an IP" do
        input :ipaddr, 
              :prompt      => "IP address",
              :description => "The IP address to #{act}",
              :type        => :string,
              :validation  => '^\d+\.\d+\.\d+\.\d+$',
              :optional    => false,
              :maxlength   => 15

        output :output,
               :description => "Output from iptables or a human readable status",
               :display_as  => "Result"
    end
end

action "isblocked", :description => "Check if an IP is blocked" do
    display :always

    input :ipaddr, 
          :prompt      => "IP address",
          :description => "The IP address to check",
          :type        => :string,
          :validation  => '^\d+\.\d+\.\d+\.\d+$',
          :optional    => false,
          :maxlength   => 15

    output :output,
           :description => "Human readable indication if the IP is blocked or not",
           :display_as  => "Result"
end
