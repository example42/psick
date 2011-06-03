(*
Module: Pg_Hba
  Parses PostgreSQL's pg_hba.conf

Author: Aurelien Bompard <aurelien@bompard.org>

About: Reference
  The file format is described in PostgreSQL's documentation:
  http://www.postgresql.org/docs/current/static/auth-pg-hba-conf.html

About: License
  This file is licensed under the LGPLv2+, like the rest of Augeas.

About: Configuration files
  This lens applies to pg_hba.conf. See <filter> for exact locations.
*)


module Pg_Hba =
    autoload xfm

    (* Group: Generic primitives *)

    let eol     = Util.eol
    let word    = Rx.neg1
    (* Variable: ipaddr
       CIDR or ip+netmask *)
    let ipaddr   = /[0-9a-fA-F:\.]+(\/[0-9]+|[ \t]+[0-9\.]+)/

    let comma_sep_list (l:string) =
        let lns = [ label l . store word ] in
            Build.opt_list lns Sep.comma

    (* Group: Columns definitions *)

    (* View: database
       TODO: support for quoted strings *)
    let database = comma_sep_list "database"
    (* View: user
       TODO: support for quoted strings *)
    let user = comma_sep_list "user"
    (* View: address *)
    let address = [ label "address" . store ipaddr ]
    (* View: option
       part of <method> *)
    let option = [ label "option" . store word ]
    (* View: method
       can contain an <option> *)
    let method = [ label "method" . store Rx.word . ( Sep.tab . option )? ]

    (* Group: Records definitions *)

    (* View: record_local
       when type is "local", there is no "address" field *)
    let record_local = [ label "type" . store "local" ] . Sep.tab .
                       database . Sep.tab . user . Sep.tab . method

    (* Variable: remtypes
       non-local connection types *)
    let remtypes = "host" | "hostssl" | "hostnossl"

    (* View: record_remote *)
    let record_remote = [ label "type" . store remtypes ] . Sep.tab .
                        database . Sep.tab .  user . Sep.tab .
                        address . Sep.tab . method

    (* View: record
        A sequence of <record_local> or <record_remote> entries *)
    let record = [ seq "entries" . (record_local | record_remote) . eol ]

    (* View: filter
        The pg_hba.conf conf file *)
    let filter = (incl "/var/lib/pgsql/data/pg_hba.conf" .
                  incl "/etc/postgresql/*/*/pg_hba.conf" )

    (* View: lns
        The pg_hba.conf lens *)
    let lns = ( record | Util.comment | Util.empty ) *

    let xfm = transform lns filter
