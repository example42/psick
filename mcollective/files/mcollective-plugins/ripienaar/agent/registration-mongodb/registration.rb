module MCollective
    module Agent
        # A registration agent that places information from the meta
        # registration class into a mongo db instance.
        #
        # To get this going you need:
        #
        #  - The meta registration plugin everywhere [1]
        #  - A mongodb instance
        #  - The mongo gem installed ideally with the bson_ext extension
        #
        # The following configuration options exist:
        #  - plugin.registration.mongohost where the mongodb is default: localhost
        #  - plugin.registration.mongodb the db name default: puppet
        #  - plugin.registration.collection the collection name default: nodes
        #
        # Each document will have the following data:
        #  - fqdn - the fqdn of the sender
        #  - lastseen - last time we got data from it
        #  - facts - a collection of facts
        #  - agentlist - a collection of agents on the node
        #  - classes - a collection of classes
        #
        # A unique constraint index will be created on the fqdn of the sending
        # hosts.
        #
        # Released under the terms of the Apache 2 licence, contact
        # rip@devco.net with questions
        class Registration
            attr_reader :timeout, :meta

            def initialize
                @meta = {:license => "Apache 2",
                         :author => "R.I.Pienaar <rip@devco.net>",
                         :url => "http://code.google.com/p/mcollective-plugins/"}

                require 'mongo'

                @timeout = 2

                @config = Config.instance

                @mongohost = @config.pluginconf["registration.mongohost"] || "localhost"
                @mongodb = @config.pluginconf["registration.mongodb"] || "puppet"
                @collection = @config.pluginconf["registration.collection"] || "nodes"

                Log.instance.debug("Connecting to mongodb @ #{@mongohost} db #{@mongodb} collection #{@collection}")

                @dbh = Mongo::Connection.new(@mongohost).db(@mongodb)
                @coll = @dbh.collection(@collection)

                @coll.create_index("fqdn", {:unique => true, :dropDups => true})
            end

            def handlemsg(msg, connection)
                req = msg[:body]

                req["fqdn"] = req[:facts]["fqdn"]
                req["lastseen"] = Time.now.to_i

                # Sometimes facter doesnt send a fqdn?!
                if req["fqdn"].nil?
                    Log.instance.debug("Got stats without a FQDN in facts")
                    return nil
                end

                # try to find a current document
                id = @coll.find({"fqdn" => req["fqdn"]})

                # Found none? then insert one else update the current one
                if id.count == 0
                    before = Time.now.to_f
                    id = @coll.save(req)
                    after = Time.now.to_f

                    Log.instance.debug("Adding new data for host #{req["fqdn"]} in #{after - before}s")
                else
                    firstid = id.next_document['_id']

                    req["_id"] = firstid

                    before = Time.now.to_f
                    @coll.save(req)
                    after = Time.now.to_f
                    Log.instance.debug("Updated data for host #{req["fqdn"]} with id #{firstid} in #{after - before}s")
                end

                nil
            end

            def help
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby

