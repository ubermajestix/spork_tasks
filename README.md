Spork Tasks
===========
Spork is kind of annoying to deal with. I just want it to run in the background and have an easy way to restart, start, and stop it. So here are my tasks for doing that. 

You can copy the rake tasks wherever you like, but I've packaged them as a rails generator

Installing
----------
    
    gem install spork_tasks
    
    # If you're using Bundler:
    gem 'spork_tasks', '~> 1.0.0'
    
    rails generate spork_tasks
    # Copies the rake file for you.

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