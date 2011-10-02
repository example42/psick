# Ensures that lines that contains $pattern are replaced by $replacement 
# Expressely tuned for management of variables in perl scripts:
# Works with patterns like my($db_user)

define replacelinepm($file, $pattern, $replacement) {
    $pattern_escaped = slash_escape($pattern)
    $replacement_escaped = regexp_escape($replacement)
    $pattern_filtered = substitute($pattern,"/$","/$")
    $replacement_filtered = substitute($replacement,"[$]","\\$")
    exec {
               "sed -i -e \"s/^.*$pattern_escaped.*$/$replacement_escaped/\" $file":
        unless => "grep -G \"$replacement_filtered\" $file", 
    }
}
