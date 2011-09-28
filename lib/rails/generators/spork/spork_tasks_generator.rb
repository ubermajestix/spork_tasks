class SporkTasksGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../.", __FILE__)
 
  def copy_initializer_file
    puts "="*45
    puts "sporking"
    puts "="*45
    copy_file "spork.rake", "lib/tasks/spork.rake"
  end
end