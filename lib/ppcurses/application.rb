module PPCurses

  # Based on the Cocoa NSResponder
  #
  # Current link, which probably won't be valid in the future ...
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSResponder_Class/index.html#//apple_ref/occ/instp/NSResponder/menu
  #
  class Responder

    attr_accessor :next_responder

    #
    # Whether the responder accepts first responder status.
    #
    # As first responder, the receiver is the first object in the responder chain to be sent key events
    # and action messages. By default, this property is NO. Subclasses set this property to YES if the
    # receiver accepts first responder status.
    #
    def accepts_first_responder
      NO
    end

    #
    # Notifies the receiver that it’s about to become first responder
    #
    # The default implementation returns YES, accepting first responder status. Subclasses can override
    # this method to update state or perform some action such as highlighting the selection, or to
    # return NO, refusing first responder status.
    #
    def become_first_responder
      YES
    end

    #
    # Notifies the receiver that it’s been asked to relinquish its status as first responder in its window.
    #
    # The default implementation returns YES, resigning first responder status. Subclasses can override
    # this method to update state or perform some action such as unhighlighting the selection, or to
    # return NO, refusing to relinquish first responder status.
    #
    def resign_first_responder
      YES
    end

    #
    # Informs the receiver that the user has pressed a key.
    #
    # The default implementation simply passes this message to the next responder.
    #
    def key_down( key )
      @next_responder.key_down(key) unless @next_responder.nil?
    end

    def Responder.isa( obj )
      PPCurses.implements_protocol( obj, %w(accepts_first_responder become_first_responder resign_first_responder key_down))
    end

  end

#=======================================================================================================================
  #
  # Derived from methods defined in Cocoa NSWindow
  #
  # Current link, which probably won't be valid in the future ...
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSWindow_Class/index.html#//apple_ref/occ/instm/NSWindow
  #
  class ResponderManager < Responder

    # The first responder is the first object in a responder chain to receive an event or action message.
    attr_accessor :first_responder

    def accepts_first_responder
      YES
    end

    #
    # Attempts to make a given responder the first responder
    #
    #
    # If responder isn’t already the first responder, this method first sends a resign_first_responder message
    # to the object that is the first responder. If that object refuses to resign, it remains the first responder,
    # and this method immediately returns NO. If the current first responder resigns, this method sends a
    # become_first_responder message to responder.
    #
    # If responder does not accept first responder status, the ResponderManager becomes first responder; in
    # this case, the method returns YES even if the responder refused first responder status.
    #
    # If responder is nil, this method still sends resign_first_responder to the current first responder.
    #
    def make_first_responder( responder )

      Responder.isa(responder) unless responder.nil?

      if responder != @first_responder
        will_resign = responder.resign_first_responder
        unless will_resign
          return NO
        end
      end

      @first_responder = nil

      accepted = NO
      will_accept = responder.accepts_first_responder

      if will_accept
        accepted = responder.become_first_responder
      end

      unless accepted
        @first_responder = self
        return YES
      end

      @first_responder = responder

      YES
    end


  end

#=======================================================================================================================

  # noinspection RubyClassVariableUsageInspection
  class Application < ResponderManager

    @@shared_app

    attr_accessor :main_menu

    # Any object of type PPCurses:View
    attr_accessor :content_view

    def initialize
      @screen = PPCurses::Screen.new

      @main_menu = create_default_menubar
      @next_responder = @main_menu

      @@shared_app = self
      @terminated = false
    end


    def content_view=(value)
      
      if @content_view != nil then
        # Clear current content_view before reassignment
        frame = @content_view.frame
        x = frame.origin.x
        y = frame.origin.y
        height = frame.size.height
        
        for i in y..y+height-1
          @screen.setpos( i, x )        
          @screen.clrtoeol  ## TODO use width !!!
        end
        
      end
      
      @content_view=value
      @main_menu.next_responder=@content_view
    end

    def create_default_menubar
      menubar = PPCurses::MenuBar.new

      quit_item = PPCurses::MenuBarItem.new('q', 'Quit')
      quit_item.action = method(:terminate)
      menubar.add_menu_item(quit_item)

      menubar
    end


    # Informal protocol
    # A delegate receives notifications if and only if a method is defined
    #
    # applicationDidFinishLaunching
    # applicationShouldTerminate
    #
    def set_delegate (delegate)
      @delegate = delegate
    end


    def launch
      @screen.setup_curses
      if @delegate.respond_to?(:applicationDidFinishLaunching)
        @delegate.applicationDidFinishLaunching(self)
      end

      until @terminated
        # TODO - switch show to display?
        @main_menu.show(@screen) unless @main_menu.nil?

        # TODO -- pass a subview of the screen.
        @content_view.display(@screen) unless @content_view.nil?

        c = @screen.get_ch
        key_down(c)
      end

      @screen.shutdown_curses

    end

    def terminate

      # Cocoa returns an NSApplicationTerminateReply which can
      # be a cancel, now or later response.  Simply support a boolean
      # for now.
      if @delegate.respond_to?(:applicationShouldTerminate)
        should_terminate = @delegate.applicationShouldTerminate(self)
        unless should_terminate
          return
        end
      end

      @terminated = true
    end

    def Application.sharedApplication
      @@shared_app
    end



  end

end
