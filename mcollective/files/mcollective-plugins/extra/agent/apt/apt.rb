module MCollective
    module Agent
        class Apt<RPC::Agent
            metadata    :name        => "SimpleRPC Agent For APT Management",
                        :description => "Agent To Manage APT",
                        :author      => "Mark Stanislav",
                        :license     => "GPLv2",
                        :version     => "1.1",
                        :url         => "https://github.com/mstanislav/mCollective-Agents",
                        :timeout     => 90

            def upgrades_action
                reply.data = %x[echo -e 'n\n '| /usr/bin/apt-get -q dist-upgrade 2>/dev/null | grep "upgraded," | awk '{ print $1 }'].chomp
            end

            def installed_action
                reply.data = %x[/usr/bin/dpkg -l 2>/dev/null | grep "^ii" | wc -l].chomp
            end

            def clean_action
                reply.data = %x[/usr/bin/apt-get clean > /dev/null 2>&1 && echo OK || echo FAILED].chomp
            end

            def update_action
                reply.data = %x[/usr/bin/apt-get update > /dev/null 2>&1 && echo OK || echo FAILED].chomp
            end
        end
    end
end

