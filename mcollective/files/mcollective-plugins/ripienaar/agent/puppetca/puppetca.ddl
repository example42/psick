metadata    :name        => "SimpleRPC Service Agent",
            :description => "Agent to manage services using the Puppet service provider", 
            :author      => "R.I.Pienaar",
            :license     => "Apache 2.0",
            :version     => "1.1",
            :url         => "http://mcollective-plugins.googlecode.com/",
            :timeout     => 20

action "clean", :description => "Performs a puppetca --clean on a certficate" do
    input :certname, 
          :prompt      => "Certificate Name",
          :description => "Certificate Name to clean",
          :type        => :string,
          :validation  => '^[a-zA-Z\-_\d\.]+$',
          :optional    => false,
          :maxlength   => 100

    output :msg,
           :description => "Human readable status message",
           :display_as  => "Result"
end

action "revoke", :description => "Revokes a certificate" do
    input :certname, 
          :prompt      => "Certificate Name",
          :description => "Certificate Name to revoke",
          :type        => :string,
          :validation  => '^[a-zA-Z\-_\d\.]+$',
          :optional    => false,
          :maxlength   => 100

    output :out,
           :description => "Output from puppetca",
           :display_as  => "Result"
end

action "sign", :description => "Signs a certificate request" do
    input :certname, 
          :prompt      => "Certificate Name",
          :description => "Certificate Name to sign",
          :type        => :string,
          :validation  => '^[a-zA-Z\-_\d\.]+$',
          :optional    => false,
          :maxlength   => 100

    output :out,
           :description => "Output from puppetca",
           :display_as  => "Result"
end

action "list", :description => "Lists all requested and signed certificates" do
    #display :always

    output :requests,
           :description => "Waiting CSR Requests",
           :display_as  => "Waiting CSRs"

    output :signed,
           :description => "Signed Certificates",
           :display_as  => "Signed"
end
