# Manages one-line configuration on arbitrary files using Augeas
# 

define file2augeas (
    $file,
    $parameter,
    $value,
    $lens = "IniFile",
    $basedir = "/root",
    $comment = "# Modified by Puppet"
    ) {

$filesc = regsubst($file,'[/]','_','G')
# $filesc = shellquote($file)

    file {
        "$basedir/augeas$filesc-$parameter":
            mode => 600, owner => root, group => root,
            path => "$basedir/augeas$filesc-$parameter",
            content => template("common/augeasconfig.erb"),
            notify  => Exec["Augeas_$basedir/augeas$file-$parameter"],
    }

    exec {
        "Augeas_$basedir/augeas$file-$parameter":
            command => "augtool --noload < $basedir/augeas$filesc-$parameter",
            unless  => "grep $parameter $file | grep $value",
    }

}
