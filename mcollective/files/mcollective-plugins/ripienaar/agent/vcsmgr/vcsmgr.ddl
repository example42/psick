metadata    :name        => "Version Control System Manager",
            :description => "Manages checkouts of code managed by VCS tools", 
            :author      => "R.I.Pienaar <rip@devco.net>",
            :license     => "Apache 2",
            :version     => "0.1",
            :url         => "http://mcollective-plugins.googlecode.com/",
            :timeout     => 90

action "svn_update", :description => "Performs an SVN update on an existing checkout" do
    display :always

    input :path,
        :prompt      => "Path to update",
        :description => "The directory containing the SVN checkout",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => false,
        :maxlength    => 150
    
    output :svnout,
           :description => "Output from SVN",
           :display_as => "Output"
    
    output :author,
           :description => "Latest Author",
           :display_as => "Author"
    
    output :url,
           :description => "Repository URL",
           :display_as => "URL"
    
    output :root,
           :description => "Repository root",
           :display_as => "Root"
    
    output :revision,
           :description => "Current Revision",
           :display_as => "Revision"
    
    output :date,
           :description => "Latest Date",
           :display_as => "Date"
    
    output :path,
           :description => "Path to the repository",
           :display_as => "Path"
end

action "svn_info", :description => "Get revision info for an existing SVN checkout" do
    display :always

    input :path,
        :prompt      => "Path to update",
        :description => "The directory containing the SVN checkout",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => false,
        :maxlength    => 150
    
    output :author,
           :description => "Latest Author",
           :display_as => "Author"
    
    output :url,
           :description => "Repository URL",
           :display_as => "URL"
    
    output :root,
           :description => "Repository root",
           :display_as => "Root"
    
    output :revision,
           :description => "Current Revision",
           :display_as => "Revision"
    
    output :date,
           :description => "Latest Date",
           :display_as => "Date"
    
    output :path,
           :description => "Path to the repository",
           :display_as => "Path"
end
