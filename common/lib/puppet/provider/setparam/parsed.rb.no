require 'puppet/provider/parsedfile'

Puppet::Type.type(:setparam).provide(:parsed,
	:parent => Puppet::Provider::ParsedFile,
	:default_target => "/tmp/test",
	:filetype => :flat
) do
  desc "Supports PHP files modifications"

    text_line :comment, :match => /^#/
    text_line :blank, :match => /^\s*$/
 
    record_line :parsed,
	:fields => %w{parameter},
#	:fields => %w{parameter value},
        :rts      => /^\s+/,
	:separator => /\s*=\s*/ 


end
