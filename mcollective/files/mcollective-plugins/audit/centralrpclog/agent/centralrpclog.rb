module MCollective
    module Agent
        # An agent that receives and logs RPC Audit messages sent from the accompanying Audit plugin
        class Centralrpclog
            attr_reader :timeout, :meta

            def initialize
                @timeout = 1

                @config = Config.instance

                @meta = {:license => "Apache 2",
                         :author => "R.I.Pienaar <rip@devco.net>",
                         :url => "http://code.google.com/p/mcollective-plugins/"}
            end

            def handlemsg(msg, connection)
                request = msg[:body]

                require 'pp'

                logfile = Config.instance.pluginconf["centralrpclog.logfile"] || "/var/log/mcollective-rpcaudit.log"

                File.open(logfile, "a") do |f|
                    f.puts("#{Time.new.strftime("%D %T")} #{msg[:senderid]}> #{request.uniqid}: #{Time.at(request.time).strftime("%D %T")} caller=#{request.caller}@#{request.sender} agent=#{request.agent} action=#{request.action} #{request.data.pretty_print_inspect}")
                end

                # never reply
                nil
            end

            def help
                <<-EOH
                RPC Central Audit Agent
                =======================

                An agent that receives audit requests from an SimpleRPC Audit plugin and logs locally
                using this you can build a central audit of all SimpleRPC requests.

                Provide it with a config option:

                plugin.centralrpclog.logfile = /var/log/simplerpc-audit.log
                EOH
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby
