require 'rake'
require 'rspec/core/rake_task'

task :default do
    FileList["*/Rakefile"].exclude('stdlib/Rakefile').each do |project|
        Rake::Task.clear
        load project
        if !Rake::Task.task_defined?(:default)
            puts "No default task defined in #{project}, aborting!"
            exit -1
        else
            dir = project.pathmap("%d")
            Dir.chdir(dir) do
                default_task = Rake::Task[:default]
                default_task.invoke()
            end
        end
    end
    puts "Done building projects"
end
