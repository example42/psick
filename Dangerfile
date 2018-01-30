# set the number of lines that must be changed before this classifies as a 'Big PR'
@SDM_DANGER_BIG_PR_LINES = 50

# Identify changes type
has_danger_changes = !git.modified_files.grep(/^manifests\/.pp$|^hieradata\/common.yaml$|^data\/common.yaml$/).empty?
has_puppet_changes = !git.modified_files.grep(/.pp$/).empty?
has_hiera_changes = !git.modified_files.grep(/^hieradata\/.yaml$|^data\/.yaml$|.pp$/).empty?
has_spec_changes = !git.modified_files.grep(/spec/).empty?
is_version_bump = git.modified_files.sort == ["metadata.json", "lib/danger/version.rb"].sort

# Puppet code changes without test changes
if has_puppet_changes && !has_spec_changes
  warn("There're changes in manifests, but not tests. That's OK as long as you're refactoring existing code.", sticky: false)
end

# Tests changes without code changes
if !has_puppet_changes && has_spec_changes
  message('Changes in tests but not in manifests. Unless you are improving your tests, this should not happen.', sticky: false)
end

# Hiera changes
if has_hiera_changes
  message('There are changes on Hiera files. They will probably affect one or more nodes.', sticky: false)
end

# hiera.yaml change
if git.modified_files.include?('hiera.yaml')
  message('Oh, you are changing the environment hiera.yaml! Be careful if you are changing hierarchies')
end

# environment.conf change
if git.modified_files.include?('environment.conf')
  message('Changing environment.conf settings? That is not something you do every day :-)')
end

# Changelog plugin
changelog.have_you_updated_changelog?

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
warn('Big PR! Big changes, big things may happen! Check them.') if git.lines_of_code > @SDM_DANGER_BIG_PR_LINES


# GitHub
warn "PR is classed as Work in Progress" if github.pr_title.include? "[WIP]"

if github.pr_body.length < 5
  warn "Please provide a summary in the Pull Request description"
end



