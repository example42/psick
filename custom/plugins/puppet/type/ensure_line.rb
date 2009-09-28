require 'nsc_utils'


Puppet::Type.newtype(:ensure_line) do

    @doc = "Make sure the line :line exists in the file :file.

            If it does not already exist, the first line matching the
            regexp :pattern will be replace by :line.

            If no match against :pattern can be found either, :line is
            inserted after or before the first line matching :where,
            depending on if :addhow is set to 'append' (default) or
            'prepend'.

            If no line matches :where either, or if :where is not set,
            :line is placed first or last in the file, depending on the
            value of :addhow.

	    FIXME!
	    There are more parameters, but I don't have the energy to
	    document them right now.

            All regexps (:pattern, :sufficient, :start, :end and :where)
	    are implicitly anchored at the beginning of the line, i.e, as
	    if they always began with ^.

            NOTE: the parameter names are not very pretty, and may change
            in the future when I can think of better names.
	   "

    newparam(:name) do
	desc "Name/title"
    end

    newparam(:file) do
	desc "The file to edit"
    end

    newparam(:start) do
	desc "Ensure line exist whithin section(s) beginning with this regexp.
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newparam(:end) do
	desc "Ensure line exist whithin section(s) ended with this regexp.
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newproperty(:line) do
	desc "How the wanted line should look"

	validate do |value|
	    if value == ""
		self.fail "Parameter 'line' must not be the empty string"
	    end
	end

	def retrieve
	    resources = self.resource
	    section_start, include_section_start =
		NSC_Utils::boundary(resources, :start)
	    section_end, include_section_end =
		NSC_Utils::boundary(resources, :end)

	    wanted_line = self.value
	    searchpattern = self.resource[:pattern]
	    if searchpattern
		searchpattern = Regexp.new('^' + self.resource[:pattern])
	    end
	    sufficient = self.resource[:sufficient]
	    if sufficient
		sufficient = Regexp.new('^' + sufficient)
	    end
	    wherepattern = self.resource[:where]
	    if wherepattern
		wherepattern = Regexp.new('^' + wherepattern)
	    end
	    addhow = self.resource[:addhow]

	    @lines = File.readlines(self.resource[:file])
	    sections = NSC_Utils::extract_sections(
		    NSC_Utils::enumerate(@lines),
		    section_start, true,
		    section_end, true,
		    true)


	    case self.resource[:section]
	    when :first
		sections = sections[0,1]
	    when :last
		sections = sections[-1,1] or []
	    when :all
		sections = sections
	    end

	    if @lines.length == 0
		sections = [["", 0]]
		include_section_start = include_section_end = false
	    end

	    @to_replace = []
	    @to_add = []
	    for sect in sections
		found = rpos = ipos = false
		firstline = sect[0][1]
		lastline = sect[-1][1]
		if not include_section_start
		    sect = sect[1..-1] or []
		end
		if not include_section_end
		    sect = sect[0..-2]
		end
		for l,i in sect
		    l = l.chomp
		    if l == wanted_line
			found = i
		    elsif sufficient and sufficient.match(l)
			found = i
		    elsif searchpattern and searchpattern.match(l)
			rpos = i
		    elsif not ipos and wherepattern and wherepattern.match(l)
			ipos = i
		    end
		end

		if found
		    0
		elsif rpos
		    @to_replace.push(rpos)
		elsif ipos
		    if addhow == :prepend
			@to_add.push(ipos)
		    else
			@to_add.push(ipos + 1)
		    end
		elsif addhow == :prepend
		    @to_add.push(firstline + (include_section_start ? 0 : 1))
		elsif addhow == :append
		    @to_add.push(lastline + (include_section_end ? 1 : 0))
		else
		    self.fail('Internal error')
		end
	    end

	    ##puts "--DEBUG: to_add     = [#{@to_add.join(', ')}]"
	    ##puts "--DEBUG: to_replace = [#{@to_replace.join(', ')}]"
	    if @to_replace.length > 0
		return @lines[@to_replace[0]].chomp
	    elsif @to_add.length > 0
		return wanted_line == "" ? false : ""
	    else
		@lines = nil
		return wanted_line
	    end
	end

	def sync
	    line = self.value + "\n"
	    for i in @to_replace
		@lines[i] = line
	    end
	    for i in @to_add.reverse
		@lines.insert(i, line)
	    end
	    fp = File.new(self.resource[:file], "w")
	    fp.write(@lines.join(""))
	    fp.close()
	    @lines = nil

	    # FIXME: I have no idea what we *should* return here, but at
	    # least this makes Puppet report that something has been done.
	    # FIXME: It would be nice if we could convince Puppet to save
	    # the old version of the file in the filebucket.
	    return :true
	end
    end

    newparam(:pattern) do
	desc "Replace lines looking like this regexp.
	      If not set, an exact match against :line is done.
	     "
	defaultto false
    end

    newparam(:sufficient) do
	desc "Lines matching this regexp are sufficiently close to the target,
	      and thus the line will be deemed to exist.

	      If not set, an exact match against :line is required.
	     "
	defaultto false
    end

    newparam(:section) do
	desc "Which section(s) to ensure the line's presence in.
	      Allowed values are 'first', 'last', and 'all'.  Other
	      sections are not touched.

	      This parameter is meaningless if :start or :end is not set,
	      as there will then only be one section.
	     "
	newvalues(:first, :last, :all)
	defaultto :first
    end

    newparam(:where) do
	desc "If set, and no existing line matches :pattern, place the new
	      line after or before (according to :addhow) the first line
	      matching this regexp.  If not set, or if no line matches
	      :where, :line is added at the end of the file if :addhow is
	      append, or at the beginning of the file if :addhow is prepend.
	     "
	defaultto false
    end

    newparam(:addhow) do
	desc "Whether to append or prepend a new line."
	newvalues(:append, :prepend)
	defaultto :append
    end
end
