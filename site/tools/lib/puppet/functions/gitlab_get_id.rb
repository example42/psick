#
# gitlab_get_id.rb
#
# This function converts a gitlab ID to the relevant name
# of the relevant object type.
# This requires profile::gitlab::cli to be installed and properly configured
# on every Puppet master
#
require 'gitlab'
GITLAB_CONFIG='/etc/gitlab-cli.conf'
config = {}
File.foreach GITLAB_CONFIG do |line|
  k = line.split("=")[0].gsub("\n",'') if line =~/=/
  v = line.split("=")[1].gsub("\n",'') if line =~/=/
  config.store(k,v)
end

Puppet::Functions.create_function(:gitlab_get_id, Puppet::Functions::InternalFunction) do
  dispatch :single do
    param          'String', :entity
    param          'String', :varname
  end

  def single(entity, varname)
    endpoint = config['GITLAB_API_ENDPOINT']
    private_token = config['GITLAB_API_PRIVATE_TOKEN']
    httparty = config['GITLAB_API_HTTPARTY_OPTIONS'].gsub("'",'')

    Gitlab.endpoint = endpoint
    Gitlab.private_token = private_token
    Gitlab.httparty = eval(httparty)
    entitys="#{entity}s"
    list = Gitlab.send(entitys)

    list.each do | item |
      record = item.to_h
      result = record[id] if record[name] == varname
    end
  end
end
