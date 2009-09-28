module Puppet::Parser::Functions
    newfunction(:strftime, :type => :rvalue) do |args|
	if args.length < 1
	    self.fail("strftime(): Missing format string parameter")
	end
	fmt = args.shift()
	if args.length == 0
	    return Time.now().strftime(fmt)
	end
	self.fail("strftime(): Too many arguments")
    end
end
