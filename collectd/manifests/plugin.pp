# collectd/manifests/plugin.pp
# (C) Copyright: 2008, David Schmitt <david@dasz.at>

# Define: collectd::plugin
# A generic wrapper for a plugin configuration. This automatically loads the
# plugin before it's configuration and notifies the collectd service to reload
# its configs.
#
# Parameters:
#   namevar	- The plugin to configure.
#   lines	- an array of lines to configure the plugin.
define collectd::plugin($lines = "") {
	$content = join("\t\n", $lines)
	file {
		"collectd/plugins/${name}.conf":
			path =>  $operatingsystem ? {
                                debian  => "/etc/collectd.d/${name}.conf",
                                default => "/etc/collectd.d/${name}.conf",
                        },
			content => "LoadPlugin ${name}\n<Plugin ${name}>\n\t${content}\n</Plugin>\n",
#			mode => 0644, owner => root, group => 0,
			notify => Service['collectd'];
	}
}
