module MCollective
    module Security
        # A YAML based security plugin that doesnt actually secure anything
        # it just does the needed serialization.
        #
        # You should *NOT* use this for every day running, this exist mostly
        # to make development and testing a bit less painful
        class None < Base
            require 'etc'
            require 'yaml'

            # Decodes a message by unserializing all the bits etc, it also validates
            # it as valid using the psk etc
            def decodemsg(msg)
                YAML.load(msg.payload)
            end

            # Encodes a reply
            def encodereply(sender, target, msg, requestid, filter={})
                @log.debug("Encoded a message for request #{requestid}")

                YAML.dump({:senderid => @config.identity,
                           :requestid => requestid,
                           :senderagent => sender,
                           :msgtarget => target,
                           :msgtime => Time.now.to_i,
                           :body => msg})
            end

            # Encodes a request msg
            def encoderequest(sender, target, msg, requestid, filter={})
                @log.debug("Encoding a request for '#{target}' with request id #{requestid}")
                request = {:body => msg,
                           :senderid => @config.identity,
                           :requestid => requestid,
                           :msgtarget => target,
                           :filter => filter,
                           :msgtime => Time.now.to_i}

                # if we're in use by a client add the callerid to the main client hashes
                request[:callerid] = callerid if @initiated_by == :client

                YAML.dump(request)
            end

            # Checks the md5 hash in the request body against our psk, the request sent for validation
            # should not have been deserialized already
            def validrequest?(req)
                @stats.validated
                return true
            end

            def callerid
                "user=#{Etc.getlogin}"
            end
        end
    end
end
# vi:tabstop=4:expandtab:ai
