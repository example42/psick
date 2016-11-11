#!/usr/bin/env ruby

require 'facterdb/bin'
#FacterDB::Bin.new(ARGV).run

#osfamily='RedHat'
FacterDB.get_facts([{:osfamily => osfamily}])
