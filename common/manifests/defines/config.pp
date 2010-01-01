define config (
        $file,
        $parameter,
	$value
	) {

        augeas {
                "Config_$file-$parameter":
                context =>  "/files$file",
                changes =>  "set $parameter $value",
#                onlyif  =>  "get $parameter != $value",
        }

}

