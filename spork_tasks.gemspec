# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "spork_tasks"
  s.version     = "1.1.2"
  s.authors     = ["Tyler Montgomery"]
  s.email       = ["tyler.a.montgomery@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Rake tasks for managing Spork}
  s.description = %q{start|stop|restart tasks to manage the Spork drb server}

  s.rubyforge_project = "spork_tasks"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'rake'
  s.add_dependency 'spork'

  s.add_development_dependency 'rspec'
end
