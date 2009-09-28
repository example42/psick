require 'nsc_utils'


Puppet::Type.newtype(:replace_sections) do

    @doc = "Replace sections of lines in the file :file with :replacement.
	    All the lines of the sections are replaced by the lines in
	    :replacement; the old and the new section contents does not
	    have to be the same number of lines.

	    Sections are delimited by lines matching the regexps :start
	    and :end.  By default, the delimiting lines are not part of
	    the sections, but if the regexps start with a plus sign (+),
	    they will be.

	    Sections must be contained within groups that are delimited
	    by lines matching the regexps :group_start and :group_end.
	    See the documentation for regexp_replace_lines for further
	    details about sections and groups.

	    It is up to the caller to ensure that the replacements are
	    idempotent.
	   "

    newparam(:name) do
	desc "Name/title of action."
    end

    newparam(:file) do
	desc "The file to edit"
    end

    newparam(:group_start) do
	desc "Regexp specifying lines that start groups.
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newparam(:group_end) do
	desc "Regexp specifying lines that ends groups.
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newparam(:start) do
	desc "Only do replacements on lines after ones matching this regexp.
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newparam(:end) do
	desc "Stop replacing after reaching a line matching this regexp.
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newproperty(:replacement) do
	desc "What to replace the lines with.
	     "

	def retrieve
	    resources = self.resource
	    @replacement = self.value
	    if @replacement[-1,1] != "\n"
		@replacement = @replacement + "\n"
	    end

	    @saves = {}
	    @to_replace = []
	    NSC_Utils::on_sections(resource, @saves) do |first, sect, last|
		current = (sect.map {|l,i| l}).join('')
		if current[-1,1] != "\n"
		    current += "\n"
		end
		if current != @replacement
		    @to_replace.push([first, last, current])
		end
	    end

	    if @to_replace.length > 0
		return @to_replace[0][2].chomp
	    else
		@saves = @replacement = @to_replace = nil
		return self.value
	    end
	end

	def sync
	    lines = @saves[:lines]
	    for s,e,old in @to_replace.reverse
		##puts "--DEBUG: About to replace #{s}..#{e}"
		if s == 0  and  e == -1
		    lines.insert(0, @replacement)
		else
		    lines[s..e] = @replacement
		end
	    end

	    fp = File.new(self.resource[:file], 'w')
	    fp.write(lines.join(""))
	    fp.close()

	    @saves = @replacement = @to_replace = nil
	    # FIXME: I have no idea what we *should* return here, but at
	    # least this makes Puppet report that something has been done.
	    # FIXME: It would be nice if we could convince Puppet to save
	    # the old version of the file in the filebucket.
	    return :true
	end
    end
end
