module Puppet::Parser::Functions
    newfunction(:sprintf, :type => :rvalue) do |args|
	if args.length < 1
	    self.fail('sprintf(): Too few arguments (missing format string)')
	end
	fmt = args.shift()
	return sprintf(fmt, *args)
    end
end
