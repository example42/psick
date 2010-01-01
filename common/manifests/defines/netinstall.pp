define netinstall (
#        $source_url,
        $source_path,
        $source_filename,
        $destination_dir,
        $owner = "root",
        $group = "root",
        $work_dir = "/var/tmp",
        $extract_command = "tar -zxvf",
        $postextract_command = ""
        # $postextract_command = "./configure ; make ; make install"
        ) {

#	$source_filename = split($source_url, '[/]')

        exec {
                "Retrieve $source_path/$source_filename":
                        cwd     => "$work_dir",
			command => "wget $source_path/$source_filename",
                        creates => "$work_dir/$source_filename",
			timeout => 3600,
        }

        exec {
                "Extract $source_filename":
                        command => "mkdir -p $destination_dir ; cd $destination_dir ; $extract_command $work_dir/$source_filename",
#                        creates => "$work_dir/$source_filename",
        }

}

