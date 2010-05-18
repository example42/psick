class mailscanner::postfix inherits mailscanner {

# Postfix class should be included but postfix service startup at boot time has to be disabled
    include postfix::disableboot
    include apache::params
    include clamav::params

# Modifications to Postfix config file to enable integration with mailscanner
# NOTE: If you manage main.cf with a static file or template, you must add this line directly in the source file to avoid modifications clashes and loops:
# header_checks = regexp:/etc/postfix/header_checks
#    postfix::conf { "header_checks": value => "regexp:/etc/postfix/header_checks" }

# Modifications on a standard MailScanner.conf of the parameters needed for postfix integration.
# Don't use mailscanner::conf define if you manage with Puppet the target file
#    mailscanner::conf { "Run As User": value => "postfix" }
#    mailscanner::conf { "Run As Group": value => "postfix" }
#    mailscanner::conf { "Incoming Queue Dir": value => "/var/spool/postfix/hold" }
#    mailscanner::conf { "Outgoing Queue Dir": value => "/var/spool/postfix/incoming" }
#    mailscanner::conf { "MTA": value => "postfix" }
# We use this class with mailscanner::mailwatch and there is included the template with the complete MailScanner.conf file

    file {
        "/etc/postfix/header_checks":
        mode => 644, owner => root, group => root,
        require => Package[postfix],
        ensure => present,
        source => "puppet://$servername/mailscanner/header_checks",
    }

    file {
        "/var/spool/MailScanner/spamassassin":
        mode => 755, owner => postfix, group => postfix,
        require => [ File["MailScanner.conf"] , Package["postfix"] ],
        ensure => directory,
    }

    file {
        "/var/spool/MailScanner/quarantine":
        mode => 775, owner => postfix, group => "${apache::params::username}",
        require => [ File["MailScanner.conf"] , Package["postfix"] , Package["apache"] ],
        ensure => directory,
    }

# Note: User clamd is the one we use for clamd service. You may need to change it.
    file {
        "/var/spool/MailScanner/incoming":
        mode => 775, owner => postfix, group => "${clamav::params::username}",
        require => [ File["MailScanner.conf"] , Package["postfix"] , Class["clamav"] ],
        ensure => directory,
    }
}

