module MCollective
    module Agent
        # A SimpleRPC plugin that uses the Nagger notify system to send messages.
        #
        # Messages can be sent using the normal mc-rpc command:
        #
        # mc-rpc naggernotify sendmsg message="hello world" recipient="xmpp://you@your.com" subject="test" -v
        #
        # For information about Nagger see http://code.google.com/p/nagger/
        class Naggernotify<RPC::Agent
            require 'nagger'

            metadata    :name        => "SimpleRPC Plugin for The Nagger Nagios Notifier",
                        :description => "Agent to send messages via nagger",
                        :author      => "R.I.Pienaar",
                        :license     => "Apache License 2.0",
                        :version     => "1.2",
                        :url         => "http://mcollective-plugins.googlecode.com/",
                        :timeout     => 2

            def startup_hook
                @configfile = @config.pluginconf["nagger.configfile"] || "/etc/nagger/nagger.cfg"
            end

            action "sendmsg" do
                validate :recipient, :shellsafe
                validate :message, :shellsafe
                validate :subject, :shellsafe if request.include?(:subject)

                begin
                    nagger = Nagger::Config.new(@configfile, false)

                    if request.include?(:subject)
                        msg = Nagger::Message.new(request[:recipient], request[:message], request[:subject], "")
                    else
                        msg = Nagger::Message.new(request[:recipient], request[:message], "", "")
                    end

                    unless nagger.plugins.include?(msg.recipient.protocol.capitalize)
                        reply.fail! "Don't know how to handle protocol #{msg.recipient.protocol.capitalize}"
                    end

                    Nagger::Spool.createmsg msg

                    reply[:msg] = "Spooled message for #{request[:recipient]}"
                rescue Exception => e
                    reply.fail! "Failed to send message: #{e}"
                end
            end
        end
    end
end
# vi:tabstop=4:expandtab:ai
