# return the sha1 hash
require 'digest/sha1'

module Puppet::Parser::Functions
	newfunction(:sha1, :type => :rvalue) do |args|
		Digest::SHA1.hexdigest(args[0])
	end
end

