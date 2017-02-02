require 'time'
require 'yaml'
require 'facter'
require 'fileutils'

facts_dir = '/etc/puppetlabs/facter/facts.d/'
pkg_cache_file = facts_dir + 'upgradable_packages.yaml'
cache_ttl = 21600 #6 hours

Facter.add('upgradable_packages') do
    confine :kernel => [ 'Linux' ]
    setcode do

        if File::exist?(pkg_cache_file) then
            pkg_cache = YAML.load_file(pkg_cache_file)
            packages_hash = pkg_cache['upgradable_packages']
            cache_time = File.mtime(pkg_cache_file)
        else
            pkg_cache = nil
            cache_time = Time.at(0)
        end

        if !pkg_cache || (Time.now - cache_time) > cache_ttl
          begin

            os=Facter.value(:osfamily)

            case os
              when /Debian/
		command = "apt-get --just-print upgrade | grep '^Inst'"      
                raw_result = `#{command}`
                result = raw_result.tr('()[]', '')
                name_pos = 1
                version_pos = 2
                repo_pos = 4
              when /RedHat/
                command = "yum check-update | sed -n '/Obsoleting Packages/q;p' | grep -v '^Load' | grep -v '^$' | grep -v '^\s\\*' | awk 'NF==3{print}{}'"
                result = `#{command}`
                name_pos = 0
                version_pos = 1
                repo_pos = 2
              when /Suse/
		command = "zypper list-updates | grep 'v '  | awk 'BEGIN { FS = \"|\" } ; { print $3 $5 $2 }'"      
                result = `#{command}`
                name_pos = 0
                version_pos = 1
                repo_pos = 2
              else
                result = "NOT_IMPLEMENTED_FOR_THIS_OS" + os
            end

            # Compile packages_hash as an object from series of strings.
            packages_hash = Hash.new
            pkg_hash = Hash.new
            result.each_line do |package|
              package_array = package.split
              package_name = package_array[name_pos]
              pkg_hash[package_name] = {}
              pkg_hash[package_name]['version'] = package_array[version_pos]
              pkg_hash[package_name]['repo'] = package_array[repo_pos]

              packages_hash.merge!(pkg_hash)
            end

            cachefile_hash = Hash.new
            cachefile_hash['upgradable_packages'] = {}
            cachefile_hash['upgradable_packages'].merge!(packages_hash)
            FileUtils.mkdir_p(facts_dir) if !File::exists?(facts_dir)
            File.open(pkg_cache_file, 'w') do |out|
		YAML.dump(cachefile_hash, out)
            end

          end
        end

        # Return final packages_hash value as a fact.
        packages_hash
    end
end
