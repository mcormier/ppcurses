module PPCurses

  # View Hierarchy information:
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CocoaViewsGuide/WorkingWithAViewHierarchy/WorkingWithAViewHierarchy.html

  # Based loosely on ...
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/index.html#//apple_ref/occ/instp/NSView/subviews

  class View  < ResponderManager

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

  end

end
