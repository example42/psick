module Puppet::Parser::Functions
    newfunction(:regexp_quote, :type => :rvalue) do |args|
	if args.length != 1
	    self.fail("regexp_quote(): wrong number of arguments" +
		      " (#{args.length} for 1)")
	end
	return Regexp.quote(args[0])
    end
end
