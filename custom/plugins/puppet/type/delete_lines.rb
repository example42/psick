require 'nsc_utils'


Puppet::Type.newtype(:delete_lines) do

    @doc = "Delete lines matching regexp :pattern in the file :file.

	    Parameters are the same as for the regexp_replace_lines type
	    (except, of course, that there is no :replacement parameter).
	   "

    newparam(:name) do
	desc "Name/title"
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
	desc "Only delete lines after ones matching this regexp.
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newparam(:end) do
	desc "Stop deleting when reaching a line matching this regexp.
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newparam(:pattern) do
	desc "Delete lines looking like this regexp (implicitly anchored at
	      the beginning and end of the line).
	     "

	validate do |value|
	    if not value  or  value == ""
		self.fail "Parameter 'pattern' must not be the empty string"
	    end
	end
    end

    newparam(:skip) do
	desc "Don't delete lines looking like this regexp (implicitly
	      anchored at the beginning and end of the line).
	     "
	defaultto false

	munge do |value|
	    return (value == "") ? false : value
	end
    end

    newproperty(:ensure) do
	desc "
	     "
	newvalue(:deleted)
	defaultto :deleted

	def retrieve
	    @to_kill = []
	    @saves = {}
	    NSC_Utils::on_section_lines(self.resource, @saves) do |l,i|
		@to_kill.push(i)
	    end

	    if @to_kill.length > 0
		patsource = @saves[:pattern].source
		return self.value == patsource ? false : patsource
	    else
		@saves = nil
		return self.value
	    end
	end

	def sync
	    lines = @saves[:lines]
	    for i in @to_kill
		##puts "--DEBUG: #{i+1}: <#{lines[i].chomp}>"
		lines[i] = nil
	    end
	    lines.delete(nil)
	    fp = File.new(self.resource[:file], 'w')
	    fp.write(lines.join(""))
	    fp.close()
	    @saves = nil
	    # FIXME: I have no idea what we *should* return here, but at
	    # least this makes Puppet report that something has been done.
	    # FIXME: It would be nice if we could convince Puppet to save
	    # the old version of the file in the filebucket.
	    return :true
	end
    end

end

