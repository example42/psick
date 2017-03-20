require 'time'
require 'yaml'
require 'facter'
require 'fileutils'

facts_dir = '/etc/puppetlabs/facter/facts.d/'
grp_cache_file = facts_dir + 'groups.yaml'
cache_ttl = 21600 # Fact caching: 6 hours
def deep_simplify_record(hash, keep)
  hash.keep_if do |key, value|
    if value.is_a?(Hash)
      deep_simplify_record(value, keep)
    else
      keep.include?(key)
    end
  end
end

Facter.add('group') do
    setcode do

        if File::exist?(grp_cache_file) then
            grp_cache = YAML.load_file(grp_cache_file)
            groups_hash_reduced = grp_cache['groups']
            cache_time = File.mtime(grp_cache_file)
        else
            grp_cache = nil
            cache_time = Time.at(0)
        end

        if !grp_cache || (Time.now - cache_time) > cache_ttl
          begin

            groups_hash = YAML.load(%x{puppet resource group --to_yaml})
	    groups_hash['groups'] = groups_hash.delete('group')
            groups_hash_reduced  = Hash.new("groups")
            groups_hash_reduced['groups'] = deep_simplify_record(groups_hash['groups'], ['gid'])

            cachefile_hash = Hash.new
            cachefile_hash.merge!(groups_hash_reduced)
            FileUtils.mkdir_p(facts_dir) if !File::exists?(facts_dir)
            File.open(grp_cache_file, 'w') do |out|
		YAML.dump(cachefile_hash, out)
            end

          end
        end

        # Since they group key is already added, we return directly its
	# content.
        groups_hash_reduced['groups']
    end
end
