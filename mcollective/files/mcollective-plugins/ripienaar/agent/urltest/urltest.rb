require 'net/http'
require 'socket'
require 'ostruct'

module MCollective
    module Agent
        # An agent that performs a web get and report stats back to the client
        #
        # See http://code.google.com/p/mcollective-plugins/wiki/AgentUrltest
        #
        # Released under the terms of the GPLv2
        class Urltest<RPC::Agent
            attr_reader :timeout, :meta

            metadata    :name        => "SimpleRPC URL Testing Agent",
                        :description => "Agent that connects to a URL and returns some statistics",
                        :author      => "R.I.Pienaar",
                        :license     => "GPLv2",
                        :version     => "1.2",
                        :url         => "http://mcollective-plugins.googlecode.com/",
                        :timeout     => 60

            action "perftest" do
                validate :url, :shellsafe

                begin
                    url = URI.parse(request[:url])

                    times = {}

                    if url.scheme == "http"
                        times["beforedns"] = Time.now
                        name = TCPSocket.gethostbyname(url.host)
                        times["afterdns"] = Time.now

                        times["beforeopen"] = Time.now
                        socket = TCPSocket.open(url.host, url.port)
                        times["afteropen"] = Time.now

                        socket.print("GET #{url.request_uri} HTTP/1.1\r\nHost: #{url.host}\r\nUser-Agent: Webtester\r\nAccept: */*\r\nConnection: close\r\n\r\n")
                        times["afterrequest"] = Time.now

                        response = Array.new

                        while line = socket.gets
                            times["firstline"] = Time.now unless times.include?("firstline")

                            response << line
                        end

                        socket.close

                        times["end"] = Time.now

                        reply[:lookuptime] = times["afterdns"] - times["beforedns"]
                        reply[:connectime] = times["afteropen"] - times["beforeopen"]
                        reply[:prexfertime] = times["firstline"] - times["afteropen"]
                        reply[:startxfer] = times["firstline"] - times["afterrequest"]
                        reply[:bytesfetched] = response.join.length
                        reply[:totaltime] = times["end"] - times["beforedns"]

                        if Config.instance.pluginconf.include?("urltest.syslocation")
                            reply[:testerlocation] = Config.instance.pluginconf["urltest.syslocation"]
                        else
                            reply[:testerlocation] = "Please set plugin.urltest.syslocation"
                        end
                    else
                        reply.fail "Unsupported url scheme: #{url.scheme}"
                        return
                    end
                rescue Exception => e
                    reply.fail e.to_s
                    return
                end
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai
