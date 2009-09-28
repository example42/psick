require 'nsc_utils'


Puppet::Type.newtype(:regexp_replace_lines) do

    @doc = "Replace lines in the file :file matching regexp :pattern with
	    :replacement, unless they also match the regexp :skip. The
	    pattern is implicitly anchored at the start and end of the line.
	    The replacement text can use the standard Ruby regexp replacement
	    back-references.

	    Only lines within sections delimited by the patterns :start
	    and :end are eligible for replacement.  Sections must in turn
	    lie within \"groups\" that are delimited by the patterns
	    :group_start and :group_end.  These patterns are anchored at
	    the start of the line.

	    An open section will be canceled if the surrounding group ends,
	    and similarly an open group will be canceled if end of file is
	    reached.  However, if the end patterns are not set, the sections
	    and groups extend to the end of the group and file, respectively.
	    Similarly, if the start patterns are not set, sections and
	    groups begin at the start of the group and file, respectively.

	    By default, the lines that mark the start and end of sections
	    are not part of the sections themselves, and the lines that
	    mark the start and end of groups are not part of the groups
	    themselves.	 However, if the delimiter patterns start with a
	    plus sign (+), the corresponding lines will be counted as being
	    part of the sections or groups.

	    Note that the replacement must be idempotent.  It is an error
	    if the result of the replacement still matches :pattern.
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

    newparam(:pattern) do
	desc "Replace lines looking like this regexp (implicitly anchored at
	      the beginning and end of the line).
	     "

	validate do |value|
	    if value == ""
		self.fail "Parameter 'pattern' must not be the empty string"
	    end
	end
    end

    newparam(:skip) do
	desc "Don't replace lines looking like this regexp (implicitly
	      anchored at the beginning and end of the line).
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newproperty(:replacement) do
	desc "What to replace the lines with.
	      Standard Ruby backreferences can be used.
	     "

	def retrieve
	    @to_replace = []
	    @saves = {}
	    NSC_Utils::on_section_lines(self.resource, @saves) do |l,i|
		@to_replace.push(i)
	    end

	    if @to_replace.length > 0
		patsource = @saves[:pattern].source
		return self.value == patsource ? false : patsource
	    else
		@saves = nil
		return self.value
	    end
	end

	def sync
	    lines = @saves[:lines]
	    pattern = @saves[:pattern]
	    skip = @saves[:skip]
	    replacement = self.value
	    for i in @to_replace
		l = lines[i]
		l2 = l.chomp
		r = l2.sub(pattern, replacement)
		##puts "--DEBUG: #{i+1}: <#{l2}> => <#{r}>"
		if pattern.match(r) and not (skip and skip.match(r))
		    msg = "Result of replacement still matches on line #{i+1}"
		    self.fail(msg)
		end
		if l[-1,1] == "\n"
		    r += "\n"
		end
		lines[i] = r
	    end
	    fp = File.new(self.resource[:file], 'w')
	    fp.write(lines.join(""))
	    fp.close()
	    # FIXME: I have no idea what we *should* return here, but at
	    # least this makes Puppet report that something has been done.
	    # FIXME: It would be nice if we could convince Puppet to save
	    # the old version of the file in the filebucket.
	    return :true
	end
    end
end
