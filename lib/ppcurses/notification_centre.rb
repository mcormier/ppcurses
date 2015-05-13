module PPCurses

  class NotificationCentre
  
    @@default_centre = NotificationCentre.new
  
    def initialize
	  @listeners = {}
	end
  
    def NotificationCentre.default_centre
		@@default_centre
	end
	
	#  method(:terminate)
	def add_observer_and_selector_for_name( observer, selector, name, sender)
	  # TODO -- implement
	  blah = @listeners[name]
	  if blah == nil then
	    @listeners[name] = {}
	  end
	  
	  @listeners[name][sender] = [observer, selector]
	  
	end
	
	def post_notification ( name, sender )
	
	end
	
  end



end