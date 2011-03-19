metadata :name => "SimpleRPC Agent For APT Management",
            :description => "Agent To Manage APT",
            :author => "Mark Stanislav",
            :license => "GPLv2",
            :version => "1.1",
            :url => "https://github.com/mstanislav/mCollective-Agents",
            :timeout => 90

action "upgrades", :description => "Get the total number of packages available for upgrade" do
    display :always

    output "status",
          :description => "Total number of packages available for upgrade",
          :display_as => "Package Upgrades Available"
end

action "installed", :description => "Get the total number of packages installed" do
    display :always

    output "status",
          :description => "Total number of packages installed",
          :display_as => "Packages Installed"
end

action "clean", :description => "Remove all package archive files" do
    display :always

    output "status",
          :description => "Status of cleaning execution",
          :display_as => "Cleaning Execution"
end

action "update", :description => "Update repository information" do
    display :always

    output "status",
          :description => "Status of update exection",
          :display_as => "Update Execution"
end
