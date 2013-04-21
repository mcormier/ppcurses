Gem::Specification.new do |s|
  s.name        = 'ppcurses'
  s.version     = '0.0.7'
  s.date        = '2013-04-27'
  s.summary     = "Convenience classes when using curses"
  s.description = "Curses abstraction"
  s.authors     = ["Matthieu Cormier"]
  s.email       = 'mcormier@preenandprune.com'
  s.homepage    = 'https://github.com/mcormier/ppcurses'
  # TODO - manually creating this list is for chumps
  s.files       = ["lib/ppcurses.rb", "lib/ppcurses/Screen.rb", "lib/ppcurses/menu/Menu.rb", "lib/ppcurses/menu/BaseMenu.rb"]
end
