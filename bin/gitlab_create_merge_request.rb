#!/usr/bin/env ruby
require 'gitlab'
GITLAB_CONFIG='/etc/gitlab-cli.conf'
config = {}
File.foreach GITLAB_CONFIG do |line|
  k = line.split("=")[0].gsub("\n",'') if line =~/=/
  v = line.split("=")[1].gsub("\n",'') if line =~/=/
  config.store(k,v)
end
last_commit=`git log -1 --oneline`
source_branch = ARGV[0] ? ARGV[0] : 'testing'
destination_branch = ARGV[1] ? ARGV[1] : 'master'
mr_title = ARGV[2] ? ARGV[2] : "MR:  #{last_commit} to #{destination_branch}"
project_id = config['GITLAB_API_PROJECT_ID']
endpoint = config['GITLAB_API_ENDPOINT']
private_token = config['GITLAB_API_PRIVATE_TOKEN']
httparty = config['GITLAB_API_HTTPARTY_OPTIONS'].gsub("'",'')

Gitlab.endpoint = endpoint
Gitlab.private_token = private_token
Gitlab.httparty = eval(httparty)

Gitlab.create_merge_request(project_id,"#{mr_title}",options={ source_branch: source_branch, target_branch: destination_branch} )
#Gitlab.create_merge_request(project_id,"#{mr_title}",options={ source_branch: source_branch, target_branch: destination_branch, merge_when_build_succeeds: true })

