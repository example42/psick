metadata    :name        => "filemgr",
            :description => "File Manager",
            :author      => "Mike Pountney <mike.pountney@gmail.com>",
            :license     => "Apache 2",
            :version     => "0.3",
            :url         => "http://www.puppetlabs.com/mcollective",
            :timeout     => 5


action "touch", :description => "Creates an empty file or touch it's timestamp" do
    input :file,
        :prompt      => "File",
        :description => "File to touch",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,
        :maxlength    => 256
end

action "remove", :description => "Removes a file" do
    input :file,
        :prompt      => "File",
        :description => "File to remove",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,
        :maxlength    => 256
end

action "status", :description => "Basic information about a file" do
    display :always

    input :file,
        :prompt      => "File",
        :description => "File to get information for",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,
        :maxlength    => 256

    output :name,
           :description => "File name",
           :display_as => "Name"

    output :output,
           :description => "Human readable information about the file",
           :display_as => "Status"

    output :present,
           :description => "Indicates if the file exist using 0 or 1",
           :display_as => "Present"

    output :size,
           :description => "File size",
           :display_as => "Size"

    output :mode,
           :description => "File mode",
           :display_as => "Mode"

    output :md5,
           :description => "File MD5 digest",
           :display_as => "MD5"

    output :mtime,
           :description => "File modification time",
           :display_as => "Modification time"

    output :ctime,
           :description => "File change time",
           :display_as => "Change time"

    output :atime,
           :description => "File access time",
           :display_as => "Access time"

    output :mtime_seconds,
           :description => "File modification time in seconds",
           :display_as => "Modification time"

    output :ctime_seconds,
           :description => "File change time in seconds",
           :display_as => "Change time"

    output :atime_seconds,
           :description => "File access time in seconds",
           :display_as => "Access time"

    output :uid,
           :description => "File owner",
           :display_as => "Owner"

    output :gid,
           :description => "File group",
           :display_as => "Group"

    output :type,
           :description => "File type",
           :display_as => "Type"
end
