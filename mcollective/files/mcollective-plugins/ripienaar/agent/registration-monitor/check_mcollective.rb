#!/usr/bin/env ruby

# Nagios plugin to check mcollective if the registration-monitor
# is in use.
#
# http://code.google.com/p/mcollective-plugins/

require 'getoptlong'

opts = GetoptLong.new(
    [ '--directory', '-d', GetoptLong::REQUIRED_ARGUMENT],
    [ '--interval', '-i', GetoptLong::REQUIRED_ARGUMENT]
)

dir = "/var/tmp/mcollective"
interval = 300
total = 0
old = 0

opts.each do |opt, arg|
    case opt
        when '--directory'
            dir = arg
        when '--interval'
            interval = arg.to_i
    end
end

Dir.open(dir) do |files|
    files.each do |f|
        next if f.match /^\./

        fage = File.stat("#{dir}/#{f}").mtime.to_i

        total += 1

        if (Time.now.to_i - fage) > interval + 30
            old += 1
        end
    end
end

if old > 0
    puts("CRITICAL: #{old} / #{total} hosts not checked in within #{interval} seconds| totalhosts=#{total} oldhosts=#{old} currenthosts=#{total - old}")
    exit 2
else
    puts("OK: #{total} / #{total} hosts checked in within #{interval} seconds| totalhosts=#{total} oldhosts=#{old} currenthosts=#{total - old}")
    exit 0
end

