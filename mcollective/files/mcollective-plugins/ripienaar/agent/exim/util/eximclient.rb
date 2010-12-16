class CancelPressed < RuntimeError; end
class InvalidAddress < RuntimeError; end

module MCollective
    module Util
        class EximClient
            attr_reader :discovered_clients

            # Initializes things, you need to give it a fully configured up copy of
            # MCollective::Client, specifically you should have set options already.
            #
            # If you set true as the 2nd param it'll load up rdialog for you so you
            # can use the helper functions.  If you dont and try to use rdialog
            # related functions you'll get weird exceptions.
            def initialize(client, with_rdialog=false)
                @discovered_clients = nil
                @client = client
                @options = client.options

                if with_rdialog
                    require 'rdialog'

                    @dialog = RDialog.new
                    @dialog.backtitle = "Exim Collective"
                    @dialog.itemhelp = true
                end
            end

            # Displays some text while you do something in the background
            def infobox(msg, title, height = 5, width = 40)
                    @dialog.title = "\"#{title}\""
                    @dialog.infobox("\n" + msg, height, width)
            end

            # Show the string in a dialog box with a specified title
            def textbox(msg, title)
                    File.open("/tmp/tmp.#{$$}", 'w') {|f| f.write("\n" + msg.to_s) }
            
                    title.sub!(/"/, "\\\"")
            
                    @dialog.title = "\"#{title}\""
                    @dialog.textbox("/tmp/tmp.#{$$}")
                    File.unlink("/tmp/tmp.#{$$}")
            end
            
            # Ask the user for something, return the entered text
            def ask(what, title)
                    @dialog.title = "\"#{title}\""
            
                    res = @dialog.inputbox("'#{what}'")
            
                    raise CancelPressed.new unless res
            
                    res
            end
            
            # Shows a list of options and lets the user choose one
            def choose(choices, title)
                    @dialog.title = "\"#{title}\""
                    res = @dialog.menu(title, choices)
            
                    raise CancelPressed.new unless res
            
                    res
            end

            # does a discovery and store the discovered clients so we do not need to do 
            # a discovery for every command we wish to run
            def discover
                if @discovered_clients == nil
                    @discovered_clients = @client.discover(@options[:filter], @options[:disctimeout])
                end

                @discovered_clients
            end

            # Resets the client so it will rediscover etc
            def reset
                @discovered_clients = nil
            end

            # helper to return the text of responses from hosts in a consistant way
            def printhostresp(response)
                text = ""
                response.each do |resp|
                    if resp[:body].is_a?(String)
                        text += "#{resp[:senderid]}:"
                        text += "     " + resp[:body].split("\n").join("\n     ") + "\n\n"
                    elsif resp[:body].is_a?(Array)
                        text += "#{resp[:senderid]}:"
                        text += "     " + resp[:body].join("\n     ") + "\n\n"
                    else
                        text += "#{resp[:senderid]} responded with a #{resp[:body].class}"
                    end
                end

                text
            end

            # helper that returns the text of the mailq in a way similar to the exim mailq command
            def printmailq(mailq)
                text = ""
                mailq.each do |m|
                    m[:frozen] ? frozen = "*** frozen ***" : frozen = ""
                
                    text += "%3s%6s %s %s %s\n" % [ m[:age], m[:size], m[:msgid], m[:sender], frozen ]
                
                    m[:recipients].each do |r|
                        text += "          #{r}\n"
                    end
                
                    text += "\n"
                end

                text
            end

            # Creates a request that confirms with what the remote end expects.  Sends the 
            # request off to the collective and either runs your block with the response 
            # or returns it.
            def req(command, recipient="", sender="", msgid="", queuematch="")
                req  = {:command => command,
                        :recipient => recipient,
                        :sender => sender,
                        :msgid => msgid,
                        :queuematch => queuematch}

                result = []
                @client.req(req, "exim", @options, discover.size) do |resp|
                    if block_given?
                        yield(resp)
                    else
                        result << resp
                    end
                end

                return [result].flatten unless block_given?
            end

            # Retrieves the mailq and returns the array of data
            def mailq
                mailq = []

                req("mailq") do |resp|
                    mailq.concat [resp[:body]].flatten
                end

                mailq
            end

            # Takes the mailq output and pass it through exiqsum, exiqsum must be locally avail
            def summarytext
                File.open("/tmp/tmp.#{$$}", 'w') {|f| f.write(printmailq(mailq)) }

                out = %x[/bin/cat /tmp/tmp.#{$$} | /usr/sbin/exiqsumm]

                File.unlink("/tmp/tmp.#{$$}")

                out
            end

            # Retries delivery for a specified message 
            def retrymsg(msgid)
                req("retrymsg", "", "", msgid, "")
            end

            # Adds a recipient to a given message
            def addrecipient(msgid, recipient)
                req("addrecipient", recipient, "", msgid, "")
            end

            # Sets the sender for a messageid
            def setsender(msgid, sender)
                req("setsender", "", sender, msgid, "")
            end

            # Mark an entire message as delivered
            def markmsgdelivered(msgid)
                req("markmsgdelivered", "", "", msgid, "")
            end

            # Marks a single recipient on a message as delivered
            def markrecipdelivered(msgid, recipient)
                req("markrecipdelivered", recipient, "", msgid, "")
            end

            # Freeze a message
            def freeze(msgid)
                req("freeze", "", "", msgid, "")
            end

            # Unfreeze a message
            def thaw(msgid)
                req("thaw", "", "", msgid, "")
            end

            # Gives up on a message with NDR
            def giveup(msgid)
                req("giveup", "", "", msgid, "")
            end

            # Removes a specified message from the queue
            def rm(msgid)
                req("rm", "", "", msgid, "")
            end

            # Delivers all messages matching a patten
            def delivermatching(pattern)
                req("delivermatching", "", "", "", pattern)
            end

            # Does a routing test
            def testaddress(address)
                req("testaddress", address, "", "", "")
            end

            # Simple/naive email validation
            def validemail?(email)
                return true if email == ""
                return false if email =~ /\`/
                return false unless email =~ /^\S+\@\S+$/

                true
            end

            # Catchall for the rest, they're mostly the same but this gives us the ability
            # to only improve when needed
            def method_missing(method_name, *args)
                req(method_name.to_s)
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby
