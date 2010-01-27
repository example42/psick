# escapes regexp metachars in a String
module Puppet::Parser::Functions
   newfunction(:regexp_escape, :type => :rvalue,
	:doc => "Escapes RegExp metacharacters") do |vals|
	vals[0] = Regexp.escape(vals[0])  
	vals[0].gsub(/[']/, '\\\\\'') 
  # args[0].gsub(%r{/}, '')
      ## [ \ ^ $ . | ? * + ( ) 
   end
end
