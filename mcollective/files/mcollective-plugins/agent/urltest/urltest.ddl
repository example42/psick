metadata    :name        => "SimpleRPC URL Testing Agent",
            :description => "Agent that connects to a URL and returns some statistics", 
            :author      => "R.I.Pienaar",
            :license     => "GPLv2",
            :version     => "1.2",
            :url         => "http://mcollective-plugins.googlecode.com/",
            :timeout     => 60

action "perftest", :description => "Permform URL test" do
    display :always

    input :url, 
          :prompt      => "URL",
          :description => "The URL to test, only http is supported",
          :type        => :string,
          :validation  => '^http:\/\/',
          :optional    => false,
          :maxlength   => 120

    output :lookuptime,
          :description => "Time to perform DNS lookup",
          :display_as  => "DNS lookup time"

    output :connectime,
          :description => "Time to open TCP connection",
          :display_as  => "TCP connect time"

    output :prexfertime,
          :description => "Time between socket open and first reply",
          :display_as  => "Pre transfer time"

    output :startxfer,
          :description => "Time between between sending the request and receiving reply",
          :display_as  => "Request wait time"

    output :bytesfetched,
          :description => "Size of the reply in bytes",
          :display_as  => "Bytes"

    output :totaltime,
          :description => "Total test time",
          :display_as  => "Total time"

    output :testerlocation,
          :description => "Location where the server is based",
          :display_as  => "Tested from"
end
