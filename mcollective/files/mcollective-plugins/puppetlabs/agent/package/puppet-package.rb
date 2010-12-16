module MCollective
    module Agent
        # An agent that uses Reductive Labs Puppet to manage packages
        #
        # See http://code.google.com/p/mcollective-plugins/
        #
        # Released under the terms of the GPL, same as Puppet
        class Package<RPC::Agent
            metadata    :name        => "SimpleRPC Agent For Package Management",
                        :description => "Agent To Manage Packages",
                        :author      => "R.I.Pienaar",
                        :license     => "GPLv2",
                        :version     => "1.3",
                        :url         => "http://mcollective-plugins.googlecode.com/",
                        :timeout     => 180

            ["install", "update", "uninstall", "purge", "status"].each do |act|
                action act do
                    validate :package, :shellsafe
                    do_pkg_action(request[:package], act.to_sym)
                end
            end

            action "yum_clean" do
                reply.fail! "Cannot find yum at /usr/bin/yum" unless File.exist?("/usr/bin/yum")
                reply[:output] = %x[/usr/bin/yum clean all]
                reply[:exitcode] = $?.exitstatus

                reply.fail! "Yum clean failed, exit code was #{reply[:exitcode]}" unless reply[:exitcode] == 0
            end

            action "apt_update" do
                reply.fail! "Cannot find apt-get at /usr/bin/apt-get" unless File.exist?("/usr/bin/apt-get")
                reply[:output] = %x[/usr/bin/apt-get update]
                reply[:exitcode] = $?.exitstatus

                reply.fail! "apt-get update failed, exit code was #{reply[:exitcode]}" unless reply[:exitcode] == 0
            end

            private
            def do_pkg_action(package, action)
                begin
                    require 'puppet'

                    if ::Puppet.version =~ /0.24/
                        ::Puppet::Type.type(:package).clear
                        pkg = ::Puppet::Type.type(:package).create(:name => package).provider
                    else
                        pkg = ::Puppet::Type.type(:package).new(:name => package).provider
                    end

                    reply[:output] = ""
                    reply[:properties] = "unknown"

                    case action
                        when :install
                            reply[:output] = pkg.install if pkg.properties[:ensure] == :absent

                        when :update
                            reply[:output] = pkg.update if pkg.properties[:ensure] != :absent

                        when :uninstall
                            reply[:output] = pkg.uninstall

                        when :status
                            pkg.flush
                            reply[:output] = pkg.properties

                        when :purge
                            reply[:output] = pkg.purge

                        else
                            reply.fail "Unknown action #{action}"
                    end

                    pkg.flush
                    reply[:properties] = pkg.properties
                rescue Exception => e
                    reply.fail e.to_s
                end
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby
