module MCollective
    module Agent
        class Puppi<RPC::Agent
            metadata    :name        => "SimpleRPC Agent For PUPPI Commands",
                        :description => "Agent to execute PUPPI actions via MCollective",
                        :author      => "Al @ Lab42 - Cloned from R.I.Pienaar nrpe agent",
                        :license     => "Apache License 2.0",
                        :version     => "0.1",
                        :url         => "http://www.example42.com/",
                        :timeout     => 600

            action "runcommand" do
                validate :command, :shellsafe

                command = plugin_for_command(request[:command])

                if command == nil
                    reply[:output] = "No such action: #{request[:command]}" if command == nil
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

                ret = {:cmd => puppi $1}

                ret
            end
        end
    end
end
# vi:tabstop=4:expandtab:ai
