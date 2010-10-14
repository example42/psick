module MCollective
    module Agent
        # TODO: 
        #  - paths should be configurable
        #  - sometimes leaves zombies around
        class Exim
            attr_reader :timeout, :meta

            Util.loadclass("MCollective::Util::EximServer")

            include MCollective::Util::EximServer

            def initialize
                @timeout = 5
                @meta = {:license => "GPLv2",
                         :author => "R.I.Pienaar <rip@devco.net>",
                         :url => "http://code.google.com/p/mcollective-plugins/"}

                @exim = "/usr/sbin/exim"
                @mailq = "/usr/bin/mailq"
                @exiqsumm = "/usr/sbin/exiqsumm"
                @exiwhat = "/usr/sbin/exiwhat"
                @exiqgrep = "/usr/sbin/exiqgrep"
                @xargs = "/usr/bin/xargs"
                @spool = "/var/spool/exim/input"
            end

            def handlemsg(msg, connection)
                req = msg[:body]
                command = req[:command]

                begin
                    # Validate everything we get passed, saves having to do it later
                    # every time we use it
                    unless req[:recipient] == ""
                        raise("Invalid recipient address") unless validemail?(req[:recipient])
                    end

                    unless req[:sender] == ""
                        raise("Invalid sender address") unless validemail?(req[:sender])
                    end

                    unless req[:msgid] == ""
                        raise("Invalid msgid") unless validid?(req[:msgid])
                        raise("No such message") unless hasmsg?(req[:msgid])
                    end

                    unless req[:queuematch] == ""
                        raise("Invalid match") unless validmatch?(req[:queuematch])
                    end

                    Log.instance.debug("Doing command #{command}")

                    case command
                        when "mailq"
                            mailq

                        when "summary"
                            summary

                        when "retrymsg"
                            retrymsg(req[:msgid])

                        when "addrecipient"
                            addrecipient(req[:msgid], req[:recipient])

                        when "setsender"
                            setsender(req[:msgid], req[:sender])

                        when "markmsgdelivered"
                            markmsgdelivered(req[:msgid])

                        when "markrecipdelivered"
                            markrecipdelivered(req[:msgid], req[:recipient])
 
                        when "freeze"
                            freeze(req[:msgid])
 
                        when "thaw"
                            thaw(req[:msgid])
 
                        when "giveup"
                            giveup(req[:msgid])
 
                        when "rm"
                            rm(req[:msgid])

                        when "exiwhat_text"
                            exiwhat_text

                        when "rmbounces"
                            rmbounces

                        when "rmfrozen"
                            rmfrozen

                        when "runq"
                            runq

                        when "delivermatching"
                            delivermatching(req[:queuematch])

                        when "testaddress"
                            testaddress(req[:recipient])
                    end
                rescue Exception => e
                    e.to_s
                end
            end

            def help
                <<-EOH
                Foo
                EOH
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby
