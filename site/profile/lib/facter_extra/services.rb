require 'time'
require 'yaml'
require 'facter'
require 'fileutils'

facts_dir = '/etc/puppetlabs/facter/facts.d/'
svc_cache_file = facts_dir + 'services.yaml'
cache_ttl = 21600 # Fact caching: 6 hours

Facter.add('services') do
    setcode do

        if File::exist?(svc_cache_file) then
            svc_cache = YAML.load_file(svc_cache_file)
            services_hash = svc_cache['services']
            cache_time = File.mtime(svc_cache_file)
        else
            svc_cache = nil
            cache_time = Time.at(0)
        end

        if !svc_cache || (Time.now - cache_time) > cache_ttl
          begin

            services_hash = YAML.load(%x{puppet resource service --to_yaml})
            services_hash['services'] = services_hash.delete('service')

            cachefile_hash = Hash.new
            cachefile_hash.merge!(services_hash)
            FileUtils.mkdir_p(facts_dir) if !File::exists?(facts_dir)
            File.open(svc_cache_file, 'w') do |out|
		YAML.dump(cachefile_hash, out)
            end

          end
        end

        # Since they service key is already added, we return directly its
	# content.
        services_hash['services']
    end
end
