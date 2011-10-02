# Finds lines beginning with $pattern and substitutes entire line with $replacement
# Based on different alternatives found on puppet public repos or discussions
# Commented alternatives can suit better according to how you escape special chars

define replaceline($file, $pattern, $replacement) {
    $pattern_escaped = regexp_escape($pattern)
    $replacement_escaped = regexp_escape($replacement)
    exec {


# OK with pattern: define(DB_USER
# NOP with pattern: my($db_user)
## sed -i -e "s/^.*my(\$db_user).*$/my\(\$db_user\)\ =\ \'mailwatch\';\ \#\ Modified\ by\ Puppet/" /usr/lib/MailScanner/MailScanner/CustomFunctions/MailWatch.pm WORKS
# OK with pattern: $CONF['database_user']
     "sed -i -e \"s/^.*$pattern.*$/$replacement_escaped/\" $file":




# BREAKS with pattern: define(DB_USER
# NOP  with pattern: my($db_user)
# OK with pattern: $CONF['database_user']
##     "sed -i -e \"s/^.*$pattern_escaped.*$/$replacement_escaped/\" $file":


# OK with pattern: define(DB_USER
# NOP with pattern: my($db_user)
## ( grep -F "my(\$db_host) " /usr/lib/MailScanner/MailScanner/CustomFunctions/MailWatch.pm WORKS )
# OK with pattern: $CONF['database_user']
    unless => "grep -F \"$replacement\" $file", 
    
    }
}
