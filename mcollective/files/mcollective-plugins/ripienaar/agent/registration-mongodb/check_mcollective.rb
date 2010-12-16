#!/usr/bin/env ruby
#
# Original one (file based) by R.I. Pienaar : http://www.devco.net
# Mongo version by Nicolas Szalay : http://www.rottenbytes.info


require 'getoptlong'
require 'mongo'

opts = GetoptLong.new(
    [ '--interval', '-i', GetoptLong::REQUIRED_ARGUMENT],
    [ '--host', '-h', GetoptLong::REQUIRED_ARGUMENT],
    [ '--database', '-d', GetoptLong::REQUIRED_ARGUMENT],
    [ '--collection', '-c', GetoptLong::REQUIRED_ARGUMENT]
)

total = 0
old = 0
interval = 300
mongohost="localhost"
mongodb="puppet"
collection="nodes"

opts.each do |opt, arg|
    case opt
        when '--interval'
            interval = arg.to_i
        when '--host'
            mongohost = arg
        when '--database'
            mongodb = arg
        when '--collection'
            collection = arg    
    end
end


dbh=Mongo::Connection.new(mongohost).db(mongodb)
coll=dbh.collection(collection)
coll.find().each { |row| 
    seen = row["lastseen"]
    fqdn = row["fqdn"]
    
    total +=1
    
    if (Time.now.to_i - seen)  > interval
        old+=1
    end
}

if old > 0
    puts("CRITICAL: #{old} / #{total} hosts not checked in within #{interval} seconds| totalhosts=#{total} oldhosts=#{old} currenthosts=#{total - old}")
    exit 2
else
    puts("OK: #{total} / #{total} hosts checked in within #{interval} seconds| totalhosts=#{total} oldhosts=#{old} currenthosts=#{total - old}")
    exit 0
end

