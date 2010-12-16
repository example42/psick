module Puppet::Parser::Functions
    newfunction(:search_setup) do |args|
        require 'puppet/util/mongoquery'

        unless args.size == 3
            raise Puppet::ParseError, "search_setup requires host, db and collection arguments"
        end

        host = args[0]
        db = args[1]
        collection = args[2]

        Puppet::Util::MongoQuery.instance.setup(host, db, collection)
    end
end
