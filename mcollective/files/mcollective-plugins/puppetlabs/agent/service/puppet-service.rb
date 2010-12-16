module MCollective
    module Agent
        # An agent that uses Reductive Labs puppet to manage services
        #
        # See http://code.google.com/p/mcollective-plugins/
        #
        # Released under the terms of the GPL, same as Puppet
        #
        # Agent is based on Simple RPC so needs mcollective 0.4.7 or newer
        class Service<RPC::Agent
            metadata    :name        => "SimpleRPC Service Agent",
                        :description => "Agent to manage services",
                        :author      => "R.I.Pienaar",
                        :license     => "GPLv2",
                        :version     => "1.2",
                        :url         => "http://mcollective-plugins.googlecode.com/",
                        :timeout     => 60

            ["stop", "start", "restart", "status"].each do |act|
                action act do
                    do_service_action(act)
                end
            end

            private
            # Creates an instance of the Puppet service provider, supports config options:
            #
            # - service.hasrestart - set this if your OS provides restart options on services
            # - service.hasstatus  - set this if your OS provides status options on services
            def get_puppet(service)
                hasstatus = false
                hasrestart = false

                if @config.pluginconf.include?("service.hasrestart")
                    hasrestart = true if @config.pluginconf["service.hasrestart"] =~ /^1|y|t/
                end

                if @config.pluginconf.include?("service.hasstatus")
                    hasstatus = true if @config.pluginconf["service.hasstatus"] =~ /^1|y|t/
                end

                require 'puppet'

                if ::Puppet.version =~ /0.24/
                    ::Puppet::Type.type(:service).clear
                    svc = ::Puppet::Type.type(:service).create(:name => service, :hasstatus => hasstatus, :hasrestart => hasrestart).provider
                else
                    svc = ::Puppet::Type.type(:service).new(:name => service, :hasstatus => hasstatus, :hasrestart => hasrestart).provider
                end

                svc
            end

            # Does the actual work with the puppet provider and sets appropriate reply options
            def do_service_action(action)
                validate :service, String

                service = request[:service]

                begin
                    Log.instance.debug("Doing #{action} for service #{service}")

                    svc = get_puppet(service)

                    unless action == "status"
                        svc.send action
                        sleep 0.5
                    end

                    reply["status"] = svc.status.to_s
                rescue Exception => e
                    reply.fail "#{e}"
                end
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby
