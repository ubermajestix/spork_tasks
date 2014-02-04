Spork Tasks
===========
Run spork in the background! Provides rake tasks for an easy way to start, stop, restart spork. 

Installing
----------
    
    # In your Gemfile:
    gem 'spork_tasks', '~> 1.1.0'

    # Add the following line to your Rakefile
    require 'spork_tasks'

Tasks
-----
    rake spork:start
    # Starts the server
    
    rake spork:stop
    # Stops the server
    
    rake spork:restart
    # Restarts spork
    
TODO
----
Better process management. Instead of guessing how long to wait (and sleep) for Rails to start, actually wait for it to start before handing the command line back.
