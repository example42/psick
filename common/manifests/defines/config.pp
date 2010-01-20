# This is a generic wrapper to different (customizable) functions of SINGLE line replacement inside a given file
# Varios third-party functions can be included and used according to necessity and contingency
# You will probably decide which line-replacement/ensurement "engine" upon:
# - augeas support on your clients
# - regular expressions matching and quotes' escapes management according to the managed configuration file syntax
# - entire $line grepping and substitution (necessary in, for example, the engine "line") or $paramenter - $value setting (used in engine $augeas, file2augeas ...)
# - your OS and how options and commands are used by different engines to find and replace strings in files

# Currentry supported "engines" and required variables:

# - Simple Example42 "augeas" engine. Based on Augeas native Type
#   Needs: $file , $pattern , $value , $engine='augeas'

# - Example42 "file2augeas" workaround to execute augtool on local files with aarbitrary path
#   Needs: $file , $pattern , $value , $engine='file2augeas'

# - David Schmitt's "line"
#   Needs: $file , $line , $pattern , $engine='line'

# - An Example42 "replaceline" 
#   Needs: $file , $line , $pattern , $engine='replaceline'

# Usage



define config (
        $file='',
	$line='',
	$pattern='',
        $parameter='',
	$value='',
	$engine=''
	) {

	case $engine {
		
		augeas: {
		        augeas {
                		"Config_$file-$parameter":
		                context =>  "/files$file",
		                changes =>  "set $parameter $value",
		#               onlyif  =>  "get $parameter != $value", 
        		}
	        }

		file2augeas: {
		        file2augeas {
                		"Config_$file-$parameter":
		                file	  => "$file",
		                parameter => "$parameter",
		                value     => "$value",
		        #        lens      => "$lens",
        		}
	        }

		line: {
		        line {
                		"Config_$file-$line":
		                file	=> "$file",
		                line    => "$line",
        		}
	        }

		replaceline: {
		        replaceline {
                		"Config_$file-$line":
		                file	  => "$file",
		                pattern   => "$pattern",
		                replacement => "$line",
        		}
	        }

		default: {
		# You may define a default
	        }

	}

}
