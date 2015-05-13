module PPCurses

  class NotificationCentre
    
    def initialize
	  @listeners = Hash.new
	end
  
     @@default_centre =  PPCurses::NotificationCentre.new
  
    def NotificationCentre.default_centre
		@@default_centre
	end
	
	#  method(:terminate)
	def add_observer( observer, selector, name, sender)

      if @listeners.has_key?(name)
	    sender_hash = @listeners.fetch(name)
      else
	    sender_hash = Hash.new
		@listeners.store(name, sender_hash)
	  end
	  
	 sender_hash.store(sender, [observer, selector])

	  
	end
	
	
	def post_notification ( name, sender )
	  
	  if @listeners.has_key?(name)
	    sender_hash =  @listeners.fetch(name)
	  end
	  
	end
	
  end



end