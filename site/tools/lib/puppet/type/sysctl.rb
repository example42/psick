Puppet::Type.newtype(:sysctl) do

    @doc = "Manages kernel parameters in /etc/sysctl.conf.  By default this will
            only edit the configuration file, and not change any of the runtime
            values.  If you wish changes to be activated right away, you can do
            so with an exec like so:

                    exec { load-sysctl:
                        command => \"/sbin/sysctl -p /etc/sysctl.conf\",
                        refreshonly => true
                    }

            Set any changes you want to happen right away to notify this command,
            or you can set it as the default:

                    Sysctl {
                        notify => Exec[load-sysctl]
                    }"

    ensurable

    newparam(:name, :namevar => true) do
        desc "Name of the parameter"
        isnamevar
    end

    newproperty(:val) do
        desc "Value the parameter should be set to"
    end

    newproperty(:target) do
        desc "Name of the file to store parameters in"
        defaultto { if @resource.class.defaultprovider and
                       @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
                        @resource.class.defaultprovider.default_target
                    else
                        nil
                    end
        }
    end
end
