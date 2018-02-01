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
source_branch = ARGV[0] ? ARGV[0] : 'integration'
destination_branch = ARGV[1] ? ARGV[1] : 'production'
mr_title = ARGV[2] ? ARGV[2] : "MR:  #{last_commit} #{source_branch} to #{destination_branch}"

project_id = config['GITLAB_API_PROJECT_ID']
endpoint = config['GITLAB_API_ENDPOINT']
private_token = config['GITLAB_API_PRIVATE_TOKEN']
httparty = config['GITLAB_API_HTTPARTY_OPTIONS'].gsub("'",'')

gitlab_user = config['GITLAB_USER']
gitlab_milestone = config['GITLAB_MILESTONE']
gitlab_labels = config['GITLAB_LABELS']
autoadd_target = config['GITLAB_TARGET_LABEL']
autoadd_source = config['GITLAB_SOURCE_LABEL']
default_target = config['GITLAB_DEFAULT_TARGET_LABEL']
default_source = config['GITLAB_DEFAULT_SOURCE_LABEL']

if autoadd_target.to_s == "true"
  gitlab_labels=gitlab_labels.to_s+default_target.to_s+destination_branch
end

if autoadd_source.to_s == "true"
  gitlab_labels=gitlab_labels.to_s+default_source.to_s+source_branch
end

gitlab_labels=gitlab_labels.to_s.split(",").compact.reject(&:empty?).join(",")

if gitlab_labels == "''"
        gitlab_labels=""
end

Gitlab.endpoint = endpoint
Gitlab.private_token = private_token
Gitlab.httparty = eval(httparty)

assignee_id=""
user_list=Gitlab.team_members(project_id)
user_list.auto_paginate do |user|
  u=user.to_h
  if u["name"] == gitlab_user or u["username"] == gitlab_user
     assignee_id= u["id"]
  end
end

milestone_id=""
milestone_list=Gitlab.milestones(project_id)
milestone_list.auto_paginate do |milestone|
  m=milestone.to_h
  if m["title"] == gitlab_milestone
     milestone_id= m["id"]
  end
end

merge_requests = Gitlab.merge_requests(project_id)
merge_requests.auto_paginate do |merge_request|
  req=merge_request.to_h
  if req["state"] == "opened"
    id=req["iid"]
    sb=req["source_branch"]
    db=req["target_branch"]
    if source_branch == sb and destination_branch == db
      print "#{mr_title}: already exist with ID Number #{id}.\n"
      print "You only need to merge it.\n"
      exit 0
    end
  end
end

print "Creating #{mr_title}\n Assignee: Name=#{gitlab_user} - Id=#{assignee_id}\n Milestone: Title=#{gitlab_milestone} - Id=#{milestone_id}\n Labels: #{gitlab_labels}\n\n"

Gitlab.create_merge_request(project_id,"#{mr_title[0..200]}",{ source_branch: source_branch, target_branch: destination_branch, labels: gitlab_labels, assignee_id: assignee_id, milestone_id: milestone_id } )
