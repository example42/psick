module MCollective
    module Registration
        # A registration plugin that sends in all the meta data we have for a node:
        #
        # - all facts
        # - all agents
        # - all classes if applicable
        # 
        # will add cf classes soon
        #
        # http://code.google.com/p/mcollective-plugins/wiki/RegistrationMetaData
        # Author: R.I.Pienaar <rip@devco.net>
        # Licence: Apache 2
        class Meta<Base
            def body
                result = {:agentlist => [],
                          :facts => {},
                          :classes => []}

                cfile = Config.instance.classesfile

                Log.instance.info("Reading classes from #{cfile}")

                if File.exist?(cfile)
                    result[:classes] = File.readlines(cfile).map {|i| i.chomp}
                end
                
                result[:agentlist] = Agents.agentlist
                result[:facts] = PluginManager["facts_plugin"].get_facts

                result
            end
        end
    end
end
# vi:tabstop=4:expandtab:ai
