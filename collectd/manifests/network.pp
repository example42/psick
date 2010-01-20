# collectd/manifests/network.pp
# (C) Copyright: 2008, David Schmitt <david@dasz.at>

# Define: collectd::network
# manage the network plugin's parameters
# 
# Parameters:
#   namevar	- ignored, there can only be one network plugin specification per node
#   listen	- The Listen statement's values. Can be an array for multiple interfaces.
#   server	- The Server statement's values. Can be an array for multiple interfaces.
#   ttl		- 1-255; set the time-to-live of sent packets.
#   forward	- 'true' or 'false' (default); If set to true, write packets
#   		  that were received via the network plugin to the sending sockets. 
#   cache_flush	- seconds, (default=1800); how often the network plugin should
#   		  flush it's caches. Since this process is somewhat expensive
#   		  and normally doesn't do much, this value should not be too
#   		  small.  The default is 1800 seconds, but setting this to
#   		  86400 seconds (one day) will not do much harm either.
define collectd::network($listen = '', $server = '', $ttl = '', $forward = 'false', $cache_flush = '1800') {
	# only allow one network specification
	# I thought about doing this as a class, but in this case of having
	# mostly configuration values and almost no functionality, I opted
	# against it to reduce possibilities for errors.
	collectd::plugin{
		'network':
			lines => [
				$listen ? { '' => '', default => "Listen ${listen}" },
				# $listen ? { '' => '', default => join('\n', regsubst($listen, '.*', 'Listen \\1', 'G', 'U')) },
				$server ? { '' => '', default => "Server ${server}" },
				# $server ? { '' => '', default => join('\n', regsubst($server, '.*', 'Server \\1', 'G', 'U')) },
				$ttl ? { '' => '', default => "TimeToLive ${ttl}" },
				$forward ? { '' => '', default => "Forward ${forward}" },
				$cache_flush ? { '' => '', default => "CacheFlush ${cache_flush}" }
			]
	}
}

