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
#last_commit="-numero ultima commit-"
source_branch = ARGV[0] ? ARGV[0] : 'development'
destination_branch = ARGV[1] ? ARGV[1] : 'testing'
mr_text = "MR: #{last_commit} from #{source_branch} to #{destination_branch}"
mr_title = ARGV[2] ? ARGV[2] : "Merged: #{last_commit} from #{source_branch} to #{destination_branch}"

project_id = config['GITLAB_API_PROJECT_ID']
endpoint = config['GITLAB_API_ENDPOINT']
private_token = config['GITLAB_API_PRIVATE_TOKEN']
httparty = config['GITLAB_API_HTTPARTY_OPTIONS'].gsub("'",'')

Gitlab.endpoint = endpoint
Gitlab.private_token = private_token
Gitlab.httparty = eval(httparty)

merge_requests = Gitlab.merge_requests(project_id, {page:1})
merge_requests.has_next_page?
merge_requests.next_page
merge_requests.auto_paginate do |merge_request|
  req=merge_request.to_h
  if req["state"] == "opened"
    mr_id=req["id"]
    sb=req["source_branch"]
    db=req["target_branch"]
    if source_branch == sb and destination_branch == db
      print "Merging id #{mr_id}: #{mr_text}\n"
      Gitlab.accept_merge_request(project_id,mr_id, { merge_commit_message: "#{mr_title}" })
      exit 0
    end
  end
end

merge_requests.auto_paginate

print "Error: Merge Request NOT Found: #{mr_text}\n"
exit 1

