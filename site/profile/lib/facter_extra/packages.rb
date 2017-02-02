require 'time'
require 'yaml'
require 'facter'
require 'fileutils'

facts_dir = '/etc/puppetlabs/facter/facts.d/'
pkg_cache_file = facts_dir + 'packages.yaml'
cache_ttl = 21600 # Fact caching: 6 hours

Facter.add('package') do
    setcode do

        if File::exist?(pkg_cache_file) then
            pkg_cache = YAML.load_file(pkg_cache_file)
            packages_hash = pkg_cache['packages']
            cache_time = File.mtime(pkg_cache_file)
        else
            pkg_cache = nil
            cache_time = Time.at(0)
        end

        if !pkg_cache || (Time.now - cache_time) > cache_ttl
          begin

            packages_hash = YAML.load(%x{puppet resource package --to_yaml})
	    packages_hash['packages'] = packages_hash.delete('package')
            
            cachefile_hash = Hash.new
            cachefile_hash.merge!(packages_hash)
            FileUtils.mkdir_p(facts_dir) if !File::exists?(facts_dir)
            File.open(pkg_cache_file, 'w') do |out|
		YAML.dump(cachefile_hash, out)
            end

          end
        end

        # Since they package key is already added, we return directly its
	# content.
        packages_hash['packages']
    end
end
