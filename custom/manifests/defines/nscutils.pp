# Courtesy of Thomas Bellman 


define fixedstring_replace_lines($file, $pattern, $replacement)
     {
        $pe = regexp_quote($pattern)
        $pe2 = ".*${pe}.*"
        regexp_replace_lines {
            "fixed--$title--$file--$pattern":
                file => $file,
                pattern => $pe2,
                replacement => $replacement;
        }
     } 

define mailwatch_setting($value)
     {
        $l = sprintf("my(\$%s) = '%s'; #Puppet was here!",
                      $name, $value)
        $p = regexp_quote("my(\$$name)")

        ensure_line {
            "mailwatch--$name":
                file => $mailwatchconf,
                line => $l,
                pattern => ".*$p.*";
        }
     } 



# Comment out lines in the file $file matching the regexp $pattern.
# The regexp is implicitly anchored at both ends of the line.
# This is only done on matching lines within sections within groups;
# see the regexp_replace_lines type for how sections and groups work.
#
# Commenting out is done by adding $comment (default "#") to the start
# of the lines, and $comment_end to the end of the lines.

define comment_lines($file, $pattern=".*", $comment="#", $comment_end="",
       		     $group_start="", $group_end="", $start="", $end="")
{
    $quoted_comment = regexp_quote($comment)
    $quoted_comment_end = regexp_quote($comment_end)

    regexp_replace_lines {
	"comment--$title--$file--$start--$end":
	    file => $file,
	    group_start => $group_start, group_end => $group_end,
	    start => $start, end => $end,
	    pattern => "${pattern}",
	    skip => "${quoted_comment}${pattern}(${quoted_comment_end})?",
	    replacement => "${comment}\\&${comment_end}";
    }
}



# Ensure that the variable $setting is set to $value for subsystem $subsystem.
# If $service is set, that service is notified when the file is changed.
#
# Note that if you need spaces or other shell metacharacters in $value,
# you need to quote it yourself.
#
# This definition is RedHat-specific, as it does its duty by editing
# the /etc/sysconfig/$subsystem file.

define sysconfig_setting($subsystem, $setting, $value, $service="")
{
    ensure_line {
	"sysconfig--${subsystem}--${setting}":
	    file => "/etc/sysconfig/${subsystem}",
	    line => "${setting}=${value}",
	    pattern => "^(#)?${setting}=.*$",
	    notify => $service ? { "" => [], default => Service[$service] };
    }
}



define portage_useflags($use)
{
    case $name {
	"GLOBAL": {
	    ensure_line {
		"portage-global-useflags":
		    file    => "/etc/make.conf",
		    line    => "USE=\"$use\"",
		    pattern => "USE=.*";
	    }
	}
	default: {
	    # FIXME: This doesn't work, because the true branch is empty.
	    # Find out what the proper syntax should be.
	#    if defined(File["/etc/portage/package.use"]) {
	#    } else {
	#	file {
	#	    "/etc/portage/package.use": ;
	#	}
	#    }
	    $quoted_package = regexp_quote($name)
	    ensure_line {
		"portage-useflags--$name":
		    file    => "/etc/portage/package.use",
		    line    => sprintf("%-24s\t%s", $name, $use),
		    pattern => "$quoted_package[ \t]+.*";
	    }
	}
    }
}



# Set options for a Xinetd service.
# Assumes that the service definition is in a file in /etc/xinetd.d
# with the same name as the service.

define xinetd_srv_option($service, $option, $value)
{
    $qopt = regexp_quote($option)
    $qval = regexp_quote($value)

    ensure_line {
	"xinetd--$service--$option":
	    file	=> "/etc/xinetd.d/$service",
	    line	=> sprintf("\t%-23s = %s", $option, $value),
	    pattern	=> sprintf("[ \t]*%s[ \t]*=", $qopt),
	    sufficient	=> sprintf("[ \t]*%s[ \t]*=[ \t]*%s[ \t]*$",
				   $qopt, $qval),
	    start	=> ".*\\{",
	    end		=> "[ \t]*\\}",
    }
}

