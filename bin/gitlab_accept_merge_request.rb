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
source_branch = ARGV[0] ? ARGV[0] : 'integration'
destination_branch = ARGV[1] ? ARGV[1] : 'production'
mr_title = ARGV[2] ? ARGV[2] : "Merged: #{last_commit} from #{source_branch} to #{destination_branch}"

project_id = config['GITLAB_API_PROJECT_ID']
endpoint = config['GITLAB_API_ENDPOINT']
private_token = config['GITLAB_API_PRIVATE_TOKEN']
httparty = config['GITLAB_API_HTTPARTY_OPTIONS'].gsub("'",'')

Gitlab.endpoint = endpoint
Gitlab.private_token = private_token
Gitlab.httparty = eval(httparty)

merge_requests = Gitlab.merge_requests(project_id)
merge_requests.auto_paginate do |merge_request|
  req=merge_request.to_h
  if req["state"] == "opened"
    mr_id=req["iid"]
    sb=req["source_branch"]
    db=req["target_branch"]
    if source_branch == sb and destination_branch == db
      print "Merging id #{project_id}/#{mr_id}: #{mr_title}\n"
      Gitlab.accept_merge_request(project_id,mr_id, { merge_when_pipeline_succeeds: true, merge_commit_message: "#{mr_title}", should_remove_source_branch: false })
      exit 0
    end
  end
end

print "Error: Merge Request NOT Found: #{mr_title}\n"
exit 1

