module MCollective
    module Agent
        class Vcsmgr<RPC::Agent
            require 'yaml'

            metadata    :name        => "Version Control System Manager",
                        :description => "Manages checkouts of code managed by VCS tools", 
                        :author      => "R.I.Pienaar <rip@devco.net>",
                        :license     => "Apache 2",
                        :version     => "0.1",
                        :url         => "http://mcollective-plugins.googlecode.com/",
                        :timeout     => 90

            def startup_hook
                @svn = @config.pluginconf["vcsmgr.svn"] || "/usr/bin/svn"
            end

            action "svn_info" do
                validate :path, :shellsafe

                reply.data.merge!(svn_info(request[:path]))
            end

            action "svn_update" do
                validate :path, :shellsafe

                svn_validcheckout?(request[:path])

                svnout = %x[#{@svn} up #{request[:path]}].chomp
                svnexit = $?.exitstatus

                reply.fail "svn up failed with exit code #{svnexit}" unless svnexit == 0

                reply[:svnout] = svnout

                reply.data.merge!(svn_info(request[:path]))
            end

            private
            def svn_validcheckout?(path)
                raise "Path doesn't exist: #{path}" unless File.exist?(path)
                raise "Path doesn't look like a svn checkout" unless File.exist?([path, ".svn"].join(File::SEPARATOR))
            end

            def svn_info(path)
                svn_validcheckout?(path)

                cmd = "#{@svn} info #{path}"
                info = YAML.load(%x[#{@svn} info #{path}])
                response = {}

                {"Last Changed Author"  => :author,
                 "URL"                  => :url,
                 "Repository Root"      => :root,
                 "Revision"             => :revision,
                 "Last Changed Date"    => :date,
                 "Path"                 => :path}.each do |k,v|
                        response[v] = info[k] || ""
                 end

                response
            end
        end
    end
end
