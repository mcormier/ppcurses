module PPCurses

  # View Hierarchy information:
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CocoaViewsGuide/WorkingWithAViewHierarchy/WorkingWithAViewHierarchy.html

  # Based loosely on ...
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/index.html#//apple_ref/occ/instp/NSView/subviews

  class View  < ResponderManager

    attr_accessor :frame

    # Extending classes should set the appropriate frame size;
    # the default implementation sets the frame to a zero rect
    # which, although avoids pointer errors, isn't very useful.
    def initialize
      @frame = Rect.zeroRect
    end
    

    ## Managing the View Hierarchy

    # superview

    # add_subview

    # subviews

    # set_subviews


    ## Drawing

    # Expects screen to be a PPCurses::Screen object
    # Need to convert to work with a window or a view.
    #
    # The default implementation does nothing
    def display(screen)

    end


    ## Key-view Loop Management

    # canBecomeKeyView

    # nextKeyView

    #

    ## Modifying the Frame Rectangle

   
    def setFrameOrigin( origin )
      @frame.origin = origin
    end
    
    
    def setFrameSize( size )
      @frame.size = size
    end


  end

end
