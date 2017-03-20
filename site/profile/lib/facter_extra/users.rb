require 'time'
require 'yaml'
require 'facter'
require 'fileutils'

facts_dir = '/etc/puppetlabs/facter/facts.d/'
usr_cache_file = facts_dir + 'users.yaml'
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

Facter.add('user') do
    setcode do

        if File::exist?(usr_cache_file) then
            usr_cache = YAML.load_file(usr_cache_file)
            users_hash_reduced = usr_cache['users']
            cache_time = File.mtime(usr_cache_file)
        else
            usr_cache = nil
            cache_time = Time.at(0)
        end

        if !usr_cache || (Time.now - cache_time) > cache_ttl
          begin

            users_hash = YAML.load(%x{puppet resource user --to_yaml})
	    users_hash['users'] = users_hash.delete('user')
            users_hash_reduced  = Hash.new("users")
            users_hash_reduced['users'] = deep_simplify_record(users_hash['users'], ['uid', 'gid', 'home'])
            cachefile_hash = Hash.new
            cachefile_hash.merge!(users_hash_reduced)
            FileUtils.mkdir_p(facts_dir) if !File::exists?(facts_dir)
            File.open(usr_cache_file, 'w') do |out|
		YAML.dump(cachefile_hash, out)
            end

          end
        end

        # Since the user key is already added, we return directly its
	# content.
        users_hash_reduced['users']
    end
end
