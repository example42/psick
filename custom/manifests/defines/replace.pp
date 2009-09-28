# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>

define replace($file, $pattern, $replacement) {
	$pattern_no_slashes = slash_escape($pattern)
	$replacement_no_slashes = slash_escape($replacement)
#	$pattern_no_slashes = $pattern
#	$replacement_no_slashes = $replacement
	exec { "replace_${pattern}_${file}":
		command => "/usr/bin/perl -pi -e 's/${pattern_no_slashes}/${replacement_no_slashes}/' '${file}'",
		onlyif => "/usr/bin/perl -ne 'BEGIN { \$ret = 1; } \$ret = 0 if /${pattern_no_slashes}/ && ! /\\Q${replacement_no_slashes}\\E/; END { exit \$ret; }' '${file}'",
		alias => "exec_$name",
	}
}

