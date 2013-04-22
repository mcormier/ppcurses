Gem::Specification.new do |s|
  s.name        = 'ppcurses'
  s.version     = '0.0.7'
  s.date        = '2013-04-27'
  s.summary     = "Convenience classes when using curses"
  s.description = "Curses abstraction"
  s.authors     = ["Matthieu Cormier"]
  s.email       = 'mcormier@preenandprune.com'
  s.homepage    = 'https://github.com/mcormier/ppcurses'
  s.files       = Dir.glob("{lib,test}/**/*") + %w(LICENCE.txt README.md)
  s.require_path = "lib"
end
