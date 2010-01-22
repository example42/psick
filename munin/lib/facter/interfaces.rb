# return the set of active interfaces as an array
Facter.add("interfaces") do
	setcode do
		`ip -o link show`.split(/\n/).collect do |line|
			value = nil
			matches = line.match(/^\d*: ([^:]*): <(.*,)?UP(,.*)?>/)
			if !matches.nil?
				value = matches[1]
			end
			value
		end.compact.sort.join(" ")
	end
end
