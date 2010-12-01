# require 'uri'

module Puppet::Parser::Functions
        newfunction(:urlhostname, :type => :rvalue, :doc => "Extracts the hostname from an url" ) do |args|
                args[0].split('/')[2]
                # URI.parse(args[0]).host
        end
end

