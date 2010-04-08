Puppet::Type.newtype(:setparam) do
  desc "Sets paramater/value lines in code or configuration files"

  newparam(:name, :namevar => true ) do
    desc "File-Parameter couple"
  end

  newproperty(:target) do
    desc "Path of file to modify"
    isrequired
    validate do |value|
      path = Pathname.new(value)
      unless path.absolute?
        raise ArgumentError, "Path must be absolute: #{path}"
      end
    end
  end

  newproperty(:parameter) do
    desc "The parameter to modify"
    isrequired
# ensurable
  end

  newparam(:value) do
    desc "The value to set for parameter"
#    isrequired
  end

end

