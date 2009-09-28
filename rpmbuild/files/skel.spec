
Summary: .
Name: 
Version: 
Release: 
License: GPL
Group: 
Source0: 
Source1: 
Patch0: 
Patch1: 
URL: 
BuildRoot: %{_tmppath}/%{name}-root
Requires: /sbin/ldconfig

%description

%prep
%setup -q

%build
%configure
make %{_smp_mflags}

%install
rm -rf %{buildroot}
%makeinstall
%find_lang %{name}

%clean
rm -rf %{buildroot}

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files -f %{name}.lang
%defattr(-, root, root)
%doc AUTHORS COPYING ChangeLog NEWS README TODO
%{_bindir}/*
%{_libdir}/*.so.*
%{_datadir}/%{name}
%{_mandir}/man8/*

%files devel
%defattr(-, root, root)
%doc HACKING
%{_libdir}/*.a
%{_libdir}/*.la
%{_libdir}/*.so
%{_mandir}/man3/*

%changelog
* Fri Feb 14 2003 Who? You
- Initial RPM release
- Source: http://freshrpms.net/docs/fight/ (check for RPM building docs)
