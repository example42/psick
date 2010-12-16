require 'ohai'

module MCollective
    module Facts
        # A factsource for OpsCode Chef
        #
        # It caches facts for 3000 seconds to speed things up a bit,
        # generally though using this plugin will slow down discovery by
        # a couple of seconds
        #
        # See: http://code.google.com/p/mcollective-plugins/wiki/FactsOpsCodeOhai
        #
        # Plugin released under the terms of the Apache Licence v 2.
        class Opscodeohai<Base
            @@last_facts_load = 0

            def get_facts
                begin 
                    if (Time.now.to_i - @@last_facts_load > 3000)
                        Log.instance.debug("Reloading facts from Ohai")
                        oh = Ohai::System.new
                        oh.all_plugins

                        @@facts = {}

                        oh.data.each_pair do |key, val|
                            ohai_flatten(key,val, [], @@facts)
                        end

                        @@last_facts_load = Time.now.to_i
                    end
                rescue
                    @@last_facts_load = Time.now.to_i
                end
    
                @@facts
            end

            private
            # Flattens the Ohai structure into something like:
            #
            #  "languages.java.version"=>"1.6.0"
            def ohai_flatten(key, val, keys, result)
                keys << key
                if val.is_a?(Mash)
                    val.each_pair do |nkey, nval|
                        ohai_flatten(nkey, nval, keys, result)
            
                        keys.delete_at(keys.size - 1)
                    end
                else
                    key = keys.join(".")
                    if val.is_a?(Array)
                        result[key] = val.join(", ")
                    else
                        result[key] = val
                    end
                end
            end
        end
    end
end
# vi:tabstop=4:expandtab:ai
