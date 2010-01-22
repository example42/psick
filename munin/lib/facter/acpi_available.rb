# return whether acpi is available -- used for deciding whether to install the munin plugin
Facter.add("acpi_available") do
    setcode do
    	if not File.exist? `which acpi 2>/dev/null`.chomp or `acpi -t -B -A 2>/dev/null`.match(/\d/).nil?
    		"absent"
    	else
    		"present"
    	end
    end
end
