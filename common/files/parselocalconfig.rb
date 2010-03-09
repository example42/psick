#!/usr/bin/ruby

# Reads the puppet YAML cache and prints out all the resources in it
# for each resource it will show the file it was defined in on the 
# master
#
# Simply pass in the path to the yaml file
#
# History:
# 2009/07/30 - Initial Release
# 2010/02/26 - Add 0.25 Support
#
# Contact:
# R.I.Pienaar <rip@devco.net> - www.devco.net - @ripienaar

# fool it into giving me the right config later on so I can guess
# about the location of localconfig.yaml as the puppetd would see things
$0 = "puppetd"

require 'puppet'
require 'yaml'

Puppet[:name] = "puppetd"
Puppet.parse_config

ARGV[0] ? localconfig = ARGV[0] : localconfig = "#{Puppet[:localconfig]}.yaml"

lc = File.open(localconfig)

begin
  pup = Marshal.load(lc)
rescue TypeError
  lc.rewind
  pup = YAML.load(lc)
rescue Exception => e
  raise
end

def printbucket(bucket)
  if bucket.class == Puppet::TransBucket
    bucket.each do |b|
      printbucket b
    end
  elsif bucket.class == Puppet::TransObject
    manifestfile = bucket.file.gsub("/etc/puppet/manifests/", "")
    puts "\t#{bucket.type}{#{bucket.name}: }\n\t\tdefined in #{manifestfile}:#{bucket.line}\n\n"
  end
end

puts("Classes included on this node:")
pup.classes.each do |klass|
  puts("\t#{klass}")
end

# 0.24 doesn't have tags in it
if pup.respond_to?("tags")
  puts("\n\nTags for this node:")
  pup.tags.each do |tag|
    puts("\t#{tag}")
  end
end

puts("\n\nResources managed by puppet on this node:")
if pup.is_a?(Puppet::TransBucket)
  printbucket pup
elsif 
  pup.extract.each do |bucket|
    printbucket bucket
  end
end

