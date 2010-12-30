# Define puppi::batch
#
# This define creates a file with a batch command that can be used locally.
#
# Usage:
# puppi::batch { "Retrieve files":
#     command   => "get_file.sh",
#     arguments => "/remote/dir/file",
#     priority  => "10",
#     user      => "root",
#     project   => "spysite",
# }
#
define puppi::batch (
    $command,
    $arguments,
    $priority="50",
    $user="root",
    $project,
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

    file { "${puppi::params::projectsdir}/$project/batch/${priority}-${name}":
        mode    => "750",
        owner   => "${nrpe::params::configfile_owner}",
        group   => "${nrpe::params::configfile_group}",
        ensure  => "${ensure}",
        require => Class["puppi"],
        content => "su - ${user} -c \"export project=${project} && ${puppi::params::scriptsdir}/${command} ${arguments}\"\n",
        tag     => 'puppi_batch',
    }

}

