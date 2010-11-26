# Inserisci qui impostazioni custom specifiche per Seat
#
class rsyslog::example42::client inherits rsyslog::client {
    File["rsyslog.conf"] {
        content => template("rsyslog/example42/client/rsyslog.conf.erb"),
    }
}
