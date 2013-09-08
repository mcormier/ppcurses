Gem::Specification.new do |s|
  s.name        = 'ppcurses'
  s.version     = '0.0.21'
  s.date        = Time.new.strftime("%Y-%m-%d")
  s.summary     = "Convenience classes when using curses"
  s.description = "Curses abstraction"
  s.authors     = ["Matthieu Cormier"]
  s.email       = 'mcormier@preenandprune.com'
  s.homepage    = 'https://github.com/mcormier/ppcurses'
  s.files       = Dir.glob("{lib,test}/**/*") + %w(LICENCE.txt README.rdoc)
  s.require_path = "lib"
  s.license     = 'MIT'

  s.post_install_message = <<END_MSG

     (  )   (   )  )
      ) (   )  (  (
      ( )  (    ) )
      _____________
     <_____________> ___
     |             |/ _ \\
     |   mmm         | | |
     |    coffee     |_| |
  ___|             |\\___/ 
 /    \\___________/    \\
 \\_____________________/

END_MSG
end
