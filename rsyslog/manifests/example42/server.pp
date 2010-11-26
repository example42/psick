# Inserisci qui impostazioni custom specifiche per Seat
#
class rsyslog::example42::server inherits rsyslog::server {

    File["rsyslog.conf"] {
        content => template("rsyslog/example42/server/rsyslog.conf.erb"),
    }

}
