Spork Tasks
===========
Run spork in the background! Provides rake tasks for an easy way to start, stop, restart spork. 

Installing
----------
    
    # In your Gemfile:
    gem 'spork_tasks', '~> 1.1.0'

    # Add the following line to your Rakefile
    require 'spork/tasks'

Tasks
-----
    rake spork:start
    # Starts the server

    rake spork:start[5678]
    # Starts spork on port 5768
    
    rake spork:stop
    # Stops the server
    
    rake spork:restart
    # Restarts spork
    
