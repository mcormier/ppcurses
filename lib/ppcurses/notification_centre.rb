module PPCurses

  class NotificationCentre
  
    @@default_centre
  
    def NotificationCentre.default_centre
	    if @@default_centre == nil then
		    @@default_centre = NotificationCentre.new
		end
		
		@@default_centre
	end
	
	
	def add_observer_and_selector_for_name( observer, selector, name, sender)
	  # TODO -- implement
	end
	
	def post_notification ( notification )
	end
	
  end

end