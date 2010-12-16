module MCollective
    module Agent
        class Nrpe<RPC::Agent
            metadata    :name        => "SimpleRPC Agent For NRPE Commands",
                        :description => "Agent to query NRPE commands via MCollective",
                        :author      => "R.I.Pienaar",
                        :license     => "Apache License 2.0",
                        :version     => "1.2",
                        :url         => "http://mcollective-plugins.googlecode.com/",
                        :timeout     => 5

            action "runcommand" do
                validate :command, :shellsafe

                command = plugin_for_command(request[:command])

                if command == nil
                    reply[:output] = "No such command: #{request[:command]}" if command == nil
                    reply[:exitcode] = 3

                    reply.fail "UNKNOWN"

                    return
                end

                reply[:output] = %x[#{command[:cmd]}].chomp
                reply[:exitcode] = $?.exitstatus

                case reply[:exitcode]
                    when 0
                        reply.statusmsg = "OK"

                    when 1
                        reply.fail "WARNING"

                    when 2
                        reply.fail "CRITICAL"

                    else
                        reply.fail "UNKNOWN"

                end

                if reply[:output] =~ /^(.+)\|(.+)$/
                    reply[:output] = $1
                    reply[:perfdata] = $2
                else
                    reply[:perfdata] = ""
                end
            end

            private
            def plugin_for_command(req)
                ret = nil

                fdir  = config.pluginconf["nrpe.conf_dir"] || "/etc/nagios/nrpe.d"
                fname = "#{fdir}/#{req}.cfg"

                if File.exist?(fname)
                    t = File.readlines(fname).first.chomp

                    if t =~ /command\[.+\]=(.+)$/
                        ret = {:cmd => $1}
                    end
                end

                ret
            end
        end
    end
end
# vi:tabstop=4:expandtab:ai
