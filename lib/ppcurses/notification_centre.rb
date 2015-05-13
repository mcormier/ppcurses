module PPCurses

  class NotificationCentre
    
    def initialize
	    @listeners = Hash.new
	  end
  
     @@default_centre =  PPCurses::NotificationCentre.new
  
    def NotificationCentre.default_centre
		  @@default_centre
	  end
	
	
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
	  
	    if @listeners.has_key?(name) == false then return end
	  
	    sender_hash =  @listeners.fetch(name)
	  
	    if sender_hash.has_key?(sender) == false then return end
	  
	    listener_info = sender_hash.fetch(sender)
	    # observer = listener_info[0]  # Currently unused
	    callback = listener_info[1] 
	  
	    notification = Notification.new(name, sender)
	  
	    callback.call ( notification )
	  end
	
  end


  class Notification
  
    attr_reader :name
	  attr_reader :object
  
    def initialize( name, object )
	    @name = name
	    @object = object
	  end
  
  
  end



end