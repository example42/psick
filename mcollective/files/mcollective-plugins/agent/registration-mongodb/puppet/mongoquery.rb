require 'rubygems'
require 'mongo'

class Puppet::Util::MongoQuery
    include Singleton

    def initialize
        @connected = false

        @host = nil
        @db = nil
        @collection = nil
    end

    # Returns just fqdn matching the query
    def find_node_names(query)
        query(query, {:fields => ["fqdn"]}).map{|result| result["fqdn"]}
    end

    # Finds all about nodes matching query
    def find_nodes(query)
        query(query).to_a
    end

    def setup(host, db, collection)
        unless (host == @host && db == @db && collection == @collection && connected?)
            @host = host
            @db = db
            @collection = collection

            connect
        end
    end

    private
    # Connect to mongodb
    def connect
        begin
            # Only reconnect if we see a new set of connection params and we arent
            # already connected to those
            unless (@host.nil? || @db.nil? || @collection.nil?)
                Puppet.notice("Creating new mongo db handle: host=#{@host} db=#{@db} collection=#{@collection}")
                @dbh = Mongo::Connection.new(@host).db(@db)
                @coll =@dbh.collection(@collection)

                @connected = true
            else
                raise Puppet::ParseError, "Cannot connect to mongo db until setup was called"
            end
        rescue Exception => e
            raise Puppet::ParseError, "Failed to connect to mongo db host=#{@host} db=#{@db} collection=#{@collection}: #{e}"
        end
    end

    # Checks if we're connected, reconnect if needed
    def query(q, opts={})
        tries = 0

        begin
            connect unless connected?

            @coll.find(q, opts)
        rescue
            retries += 1

            if retries == 5
                raise Puppet::ParseError, "Failed to query Mongo after 5 attempts"
            end

            connect
            retry
        end
    end

    # Are we connected?
    def connected?
        begin
            return true if @connected && @dbh.connection.connected?
        rescue Exception => e
            Puppet.notice("Not connected to mongo db: #{e}")
            return false
        end
    end
end
