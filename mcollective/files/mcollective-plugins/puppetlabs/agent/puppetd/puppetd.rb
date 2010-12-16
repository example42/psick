module MCollective
    module Agent
        # An agent to manage the Puppet Daemon
        #
        # Configuration Options:
        #    puppetd.splaytime - How long to splay for, no splay by default
        #    puppetd.statefile - Where to find the state.yaml file defaults to
        #                        /var/lib/puppet/state/state.yaml
        #    puppetd.lockfile  - Where to find the lock file defaults to
        #                        /var/lib/puppet/state/puppetdlock
        #    puppetd.puppetd   - Where to find the puppetd, defaults to
        #                        /usr/sbin/puppetd
        class Puppetd<RPC::Agent
            metadata    :name        => "SimpleRPC Puppet Agent",
                        :description => "Agent to manage the puppet daemon",
                        :author      => "R.I.Pienaar",
                        :license     => "Apache License 2.0",
                        :version     => "1.3",
                        :url         => "http://mcollective-plugins.googlecode.com/",
                        :timeout     => 20

            def startup_hook
                @splaytime = @config.pluginconf["puppetd.splaytime"].to_i || 0
                @lockfile = @config.pluginconf["puppetd.lockfile"] || "/var/lib/puppet/state/puppetdlock"
                @statefile = @config.pluginconf["puppetd.statefile"] || "/var/lib/puppet/state/state.yaml"
                @pidfile = @config.pluginconf["puppet.pidfile"] || "/var/run/puppet/agent.pid"
                @puppetd = @config.pluginconf["puppetd.puppetd"] || "/usr/sbin/puppetd"
            end

            action "enable" do
                enable
            end

            action "disable" do
                disable
            end

            action "runonce" do
                runonce
            end

            action "status" do
                status
            end

            private
            def status
                reply[:enabled] = 0
                reply[:running] = 0
                reply[:lastrun] = 0

                if File.exists?(@lockfile)
                    if File::Stat.new(@lockfile).zero?
                        reply[:output] = "Disabled, not running"
                    else
                        reply[:output] = "Enabled, running"
                        reply[:enabled] = 1
                        reply[:running] = 1
                    end
                else
                        reply[:output] = "Enabled, not running"
                        reply[:enabled] = 1
                end

                reply[:lastrun] = File.stat(@statefile).mtime.to_i if File.exists?(@statefile)
                reply[:output] += ", last run #{Time.now.to_i - reply[:lastrun]} seconds ago"
            end

            def runonce
                if File.exists?(@lockfile)
                    reply.fail "Lock file exists, puppetd is already running or it's disabled"
                else
                    if request[:forcerun]
                        reply[:output] = %x[#{@puppetd} --onetime]

                    elsif @splaytime > 0
                        reply[:output] = %x[#{@puppetd} --onetime --splaylimit #{@splaytime} --splay]

                    else
                        reply[:output] = %x[#{@puppetd} --onetime]
                    end
                end
            end

            def enable
                if File.exists?(@lockfile)
                    stat = File::Stat.new(@lockfile)

                    if stat.zero?
                        File.unlink(@lockfile)
                        reply[:output] = "Lock removed"
                    else
                        reply[:output] = "Currently runing"
                    end
                else
                    reply.fail "Already unlocked"
                end
            end

            def disable
                if File.exists?(@lockfile)
                    stat = File::Stat.new(@lockfile)

                    stat.zero? ? reply.fail("Already disabled") : reply.fail("Currently running")
                else
                    begin
                        File.open(@lockfile, "w") do |file|
                        end

                        reply[:output] = "Lock created"
                    rescue Exception => e
                        reply[:output] = "Could not create lock: #{e}"
                    end
                end
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby
