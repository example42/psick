

# Identify changes type
has_danger_changes = !git.modified_files.grep(/^manifests\/.pp$|^hieradata\/common.yaml$/).empty?
has_puppet_changes = !git.modified_files.grep(/.pp$/).empty?
has_spec_changes = !git.modified_files.grep(/spec/).empty?
is_version_bump = git.modified_files.sort == ["metadata.json", "lib/danger/version.rb"].sort

# Puppet code changes without test changes
if has_puppet_changes && !has_spec_changes
  warn("There're changes in manifests, but not tests. That's OK as long as you're refactoring existing code.", sticky: false)
end

# Tests changes without code changes
if !has_puppet_changes && has_spec_changes
  message('We really puppetreciate pull requests that demonstrate issues, even without a fix. That said, the next step is to try and fix the failing tests!', sticky: false)
end

# Have you updated CHANGELOG.md?
changelog.check

# Add a CHANGELOG entry for puppet changes
if !git.modified_files.include?("CHANGELOG.md") && has_puppet_changes && is_version_bump
  warn("Please include a CHANGELOG entry when changing version).")
  message "Note, we hard-wrap at 80 chars and use 2 spaces after the last line."
end

# Changes in files with large impact
if has_danger_changes
  warn("This change may impact many systems. Double check what you are doing.", sticky: false)
end


# Ensure a clean commits history
if git.commits.any? { |c| c.message =~ /^Merge branch/ }
  warn('Please rebase to get rid of the merge commits in this PR')
end

# Large PR
warn('Big PR') if git.lines_of_code > @SDM_DANGER_BIG_PR_LINES


# GitHub
warn "PR is classed as Work in Progress" if github.pr_title.include? "[WIP]"

if github.pr_body.length < 5
  warn "Please provide a summary in the Pull Request description"
end



