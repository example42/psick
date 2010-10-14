module MCollective
    module Agent
        # An agent that receives and logs RPC Audit messages sent from the accompanying Audit plugin
        #
        # It stores them in MongoDB, you can configure the mongo parameters:
        #
        #   plugin.centralrpclog.mongohost = localhost
        #   plugin.centralrpclog.mongodb = mcollective
        #   plugin.centralrpclog.collection = rpclog
        #
        # These are the defaults.  You need the mongo gem installed.
        class Centralrpclog
            attr_reader :timeout, :meta

            def initialize
                @timeout = 1

                @config = Config.instance

                @meta = {:license => "Apache 2",
                         :author => "R.I.Pienaar <rip@devco.net>",
                         :url => "http://code.google.com/p/mcollective-plugins/"}

                require 'mongo'

                @mongohost = @config.pluginconf["centralrpclog.mongohost"] || "localhost"
                @mongodb = @config.pluginconf["centralrpclog.mongodb"] || "mcollective"
                @collection = @config.pluginconf["centralrpclog.collection"] || "rpclog"

                Log.instance.debug("Connecting to mongodb @ #{@mongohost} db #{@mongodb} collection #{@collection}")

                @dbh = Mongo::Connection.new(@mongohost).db(@mongodb)
                @coll = @dbh.collection(@collection)
            end

            def handlemsg(msg, connection)
                request = msg[:body]
    
                log = request.to_hash.merge({:senderid => msg[:senderid], :requestid => request.uniqid, :caller => "#{request.caller}@#{request.sender}", :time => Time.now.to_i})

                @coll.save(log)

                # never reply
                nil
            end

            def help
                <<-EOH
                EOH
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby
