module MCollective
    module RPC
        # A RPC::Audit plugin that sends all audit messages to a non SimpleRPC agent called
        # centralrpclog where it can then process them however it feels like
        #
        # http://code.google.com/p/mcollective-plugins/
        class Centralrpclog<Audit
            def audit_request(request, connection)
                begin
                    config = Config.instance
                    target = MCollective::Util.make_target("centralrpclog", :command)
                    reqid = Digest::MD5.hexdigest("#{config.identity}-#{Time.now.to_f.to_s}-#{target}")
                    filter = {"agent" => "centralrpclog"}

                    req = PluginManager["security_plugin"].encoderequest(config.identity, target, request, reqid, filter)

                    connection.send(target, req)
                rescue Exception => e
                    Log.instance.error("Failed to send audit request: #{e}")
                end
            end
        end
    end
end
# vi:tabstop=4:expandtab:ai
