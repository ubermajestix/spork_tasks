class SporkTasksGenerator < Rails::Generators::Base
  source_root File.expand_path("../.", __FILE__)
 
  def copy_rake_tasks
    puts "="*45
    puts "Copying spork.rake into lib/tasks/"
    puts "="*45
    copy_file "spork.rake", "lib/tasks/spork.rake"
  end
end