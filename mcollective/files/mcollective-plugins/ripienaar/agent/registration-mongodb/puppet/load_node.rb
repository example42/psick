module Puppet::Parser::Functions
    newfunction(:load_node, :type => :rvalue) do |args|
        require 'puppet/util/mongoquery'

        results = Puppet::Util::MongoQuery.instance.find_nodes({"fqdn" => args[0]})

        if results.is_a?(Array)
            return results.first
        else
            raise "Could not find a node matching #{args[0]}"
        end
    end
end
