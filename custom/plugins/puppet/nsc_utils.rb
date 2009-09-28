module NSC_Utils

    def boundary(resources, name)
	include_boundary = 0
	boundary = resources[name]
	if boundary
	    if boundary[0,1] == "+"
		include_boundary = true
		boundary = boundary[1..boundary.length]
	    else
		include_boundary = false
	    end
	    boundary = Regexp.new('^' + boundary)
	end
	return [boundary, include_boundary]
    end
    module_function :boundary


    def enumerate(lines)
	result = []
	lines.each_with_index do |l,i|
	    result.push([l,i])
	end
	return result
    end
    module_function :enumerate


    def extract_sections(lines, startp, include_start, endp, include_end,
			   cancel_unclosed)
	include_start = (include_start ? 0 : 1)
	extracted = [[]]
	inside = startp ? false : -1
	for l,i in lines
	    cl = l.chomp
	    if not inside  and  startp  and  startp.match(cl)
		inside = i
		extracted.push([])
	    end
	    if inside  and  i >= inside + include_start
		extracted[-1].push([l,i])
	    end
	    if inside  and  endp  and  endp.match(cl)
		if not include_end
		    extracted[-1].pop()
		end
		inside = false
	    end
	end
	if inside  and  endp  and  cancel_unclosed
	    extracted.pop()
	end
	extracted.delete([])
	return extracted
    end
    module_function :extract_sections


    def on_sections(resources, saves)
	group_start, include_group_start =
	    NSC_Utils::boundary(resources, :group_start)
	group_end, include_group_end =
	    NSC_Utils::boundary(resources, :group_end)
	section_start, include_section_start =
	    NSC_Utils::boundary(resources, :start)
	section_end, include_section_end =
	    NSC_Utils::boundary(resources, :end)

	saves[:lines] = File.readlines(resources[:file])
	groups = NSC_Utils::extract_sections(
		NSC_Utils::enumerate(saves[:lines]),
		group_start, include_group_start,
		group_end, include_group_end,
		true)
	for grp in groups
	    sections = NSC_Utils::extract_sections(
		    grp,
		    section_start, true,
		    section_end, true,
		    true)
	    for sect in sections
		firstline = sect[0][1]
		lastline = sect[-1][1]
		if not include_section_start
		    sect = sect[1..-1] or []
		    firstline += 1
		end
		if not include_section_end
		    sect = sect[0..-2]
		    lastline -= 1
		end
		yield [firstline, sect, lastline]
	    end
	end
    end
    module_function :on_sections


    # FIXME!
    # This function is supposed to replace the on_section_lines() function
    # below.  However, it is as of yet untested, so for the time being,
    # the old implementation is the one we use.
    def on_section_lines_2(resources, saves)
	saves[:pattern] = Regexp.new('^' + resources[:pattern] + '$')
	saves[:skip] = resources[:skip]
	if saves[:skip]
	    saves[:skip] = Regexp.new('^' + saves[:skip] + '$')
	end
	NSC_Utils::on_sections do |firstline, sect, lastline|
	    for l,i in sect
		cl = l.chomp
		if saves[:pattern].match(cl)
		    unless saves[:skip]  and  saves[:skip].match(cl)
			yield [l,i]
		    end
		end
	    end
	end
    end
    module_function :on_section_lines_2


    def on_section_lines(resources, saves)
	group_start, include_group_start =
	    NSC_Utils::boundary(resources, :group_start)
	group_end, include_group_end =
	    NSC_Utils::boundary(resources, :group_end)
	section_start, include_section_start =
	    NSC_Utils::boundary(resources, :start)
	section_end, include_section_end =
	    NSC_Utils::boundary(resources, :end)
	saves[:pattern] = Regexp.new('^' + resources[:pattern] + '$')
	saves[:skip] = resources[:skip]
	if saves[:skip]
	    saves[:skip] = Regexp.new('^' + saves[:skip] + '$')
	end

	saves[:lines] = File.readlines(resources[:file])
	groups = NSC_Utils::extract_sections(
		NSC_Utils::enumerate(saves[:lines]),
		group_start, include_group_start,
		group_end, include_group_end,
		true)
	for grp in groups
	    sections = NSC_Utils::extract_sections(
		    grp,
		    section_start, include_section_start,
		    section_end, include_section_end,
		    true)
	    for sect in sections
		for l,i in sect
		    cl = l.chomp
		    if saves[:pattern].match(cl)
			unless saves[:skip]  and  saves[:skip].match(cl)
			    yield [l,i]
			end
		    end
		end
	    end
	end
    end
    module_function :on_section_lines

    if false
    _l1 = [ 'foo', 'bar', 'gazonk', 'del',
	   'apelsin', 'citron', 'fromage',
	   'choklad', 'pudding',
	  ]
    _l2 = File.readlines('/tmp/trh/grub.conf')
    _nl1 = enumerate(_l1)
    _nl2 = enumerate(_l2)
    _sp1 = /^bar|^citron/
    _ep1 = /^del|^pudding/
    _ep2 = /^del|^choklad/
    _ep3 = /^del|^fromage/
    _ep4 = /^del|^gurksallad/
    _ep5 = /^gurksallad/
    end

    X = 17
    Y = 23
    Z = 69

end
