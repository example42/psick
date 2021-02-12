#!/opt/puppetlabs/puppet/bin/ruby
#
# Authors: Martin Alfke, Simon Hönscheid - example42 GmbH
# Version 1.1
#
# Usage: Run on a Puppet Server with PuppetDB
# Read all nodes from PuppetDB and generate a random 
# root passwort for each one. Save hash and clear text
#
# Customize lines 15 and 97 to your needs
# 
# Copy class to your repository 
#
# example puppet class
# class your::puppet::class (
#   Hash $root_passwords,
# ){
#
#   if $trusted['certname'] in $root_passwords {
#     user { 'root':
#       ensure   => present,
#       password => $root_passwords[$trusted['certname']],
#     }
#   }
#   else {
#     notify { "No root password for ${trusted['certname']} in hiera." }
#   }
# }

require 'faraday'
require 'json'
require 'digest/sha2'
require 'yaml'
require 'openssl'

#help!
def usage
  script = $PROGRAM_NAME
  puts 'ERROR!!'
  puts "usage: #{script} <outputfile>"
  puts "example: #{script} /tmp/root_passwords"
  puts 'two files will be created, one with file extension .yaml, one with .plaintext_yaml'
  exit 2
end

#check for correct number of arguments
usage if ARGV.count != 1

# mapping arguments to vars
outputfile = ARGV[0]
ARGV.shift

# check if output files exist
yaml_outputfile = "#{outputfile}.yaml"
plaintext_outputfile = "#{outputfile}.plaintext_yaml"

if File.exist?(yaml_outputfile)
  puts "The file #{yaml_outputfile} already exists."
  exit 2
end
if File.exist?(plaintext_outputfile)
  puts "The file #{plaintext_outputfile} already exists."
  exit 2
end

# ask the user, if we are on a puppet server
puts 'ATTENTION: This script must run on a puppet server with Puppet DB.'
puts 'Enter yes to continue, everything else will exit the script.'

value = gets.chomp
exit 99 if value != 'yes'

def create_random_string
  source = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ['_', '-', '.', '!']
  key = ''
  32.times { key += source[rand(source.size)].to_s }
  key
end

# get all nodes from puppetdb
conn = Faraday.new
response = conn.post do |req|
  req.url 'http://localhost:8080/pdb/query/v4'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{"query":"nodes[certname] { deactivated is null and expired is null }" }'
end

# check result
if response.status != 200
  puts 'Error reading data from PuppetDB'
  puts "Status Code: #{response.status}"
  puts "Response Body: #{response.body}"
  exit 99
end

# prepare data
yaml_data = "---\nyour::puppet::class::root_passwords:\n"
plaintext_data = {}

# iterate over result
JSON.parse(response.body).each do |key|
  server = key['certname']
  root_password = create_random_string
  salt = rand(36**8).to_s(36)
  shadow_root_password = root_password.crypt('$6$' + salt)

  # add data to YAML and PLAINTEXT
  yaml_data += "  #{server}: '#{shadow_root_password}'\n"
  plaintext_data[server] = root_password
end

# wite data to YAML file and plaintext file
File.open(yaml_outputfile, 'w:UTF-8') do |file|
  file.write(yaml_data)
end
puts "YAML file #{yaml_outputfile} written"


File.open(plaintext_outputfile, 'w:UTF-8') do |file|
  file.write(plaintext_data.to_yaml)
end
puts "PLAINTEXT file #{plaintext_outputfile} written"

# check YAML file
begin
  puts 'check YAML file...'
  YAML.parse(File.open(yaml_outputfile, 'r:UTF-8'))
  puts "add #{yaml_outputfile} to your hiera data"
  puts "and #{plaintext_outputfile} to your password safe"
rescue
  puts 'YAML file has errors...'
  puts 'Deleting all files...'
  File.delete(yaml_outputfile)
  File.delete(plaintext_outputfile)
  puts 'All files deleted, try again'
end
