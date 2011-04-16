module MCollective
    module Facts
        require 'facter'

        # A factsource for Puppet Labs Facter
        #
        # This plugin by default works with puppet facts loaded via pluginsync
        # and the deprecated factsync. If your facts are in a custom location, or
        # you use non-standard puppet dirs, then set plugin.facter.facterlib
        # in the server.cfg
        #
        # See: http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/FactsFacter
        #
        # NOTE: This version of this plugin requires mcollective 1.1.0 or newer
        #
        # Plugin released under the terms of the GPL.
        class Facter_facts<Base
            def load_facts_from_source
                logger = Log.instance

                ENV['FACTERLIB'] = Config.instance.pluginconf["facter.facterlib"] || "/var/lib/puppet/lib/facter:/var/lib/puppet/facts"

                logger.debug("Have FACTERLIB: #{ENV['FACTERLIB']}")

                ::Facter.reset

                facts = ::Facter.to_hash

                logger.info("Loaded #{facts.keys.size} facts from Facter")

                facts
            end
        end
    end
end
# vi:tabstop=4:expandtab:ai
