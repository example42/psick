module Puppet::Parser::Functions
    newfunction(:search_nodes, :type => :rvalue) do |args|
        require 'puppet/util/mongoquery'

        searchspec = eval(args[0])
        Puppet::Util::MongoQuery.instance.find_node_names(searchspec)
    end
end
