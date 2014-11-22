module PPCurses

  class Window < Curses::Window

    # TODO - use optional parameters.  A rect or a Curses window to wrap.
    def initialize(height, width, top, left)
      super(height,width,top,left)

      # Enables reading arrow keys in getch
      keypad(true)

      box('|', '-')
    end



    # EXPERIMENTAL/HACK
    #
    # The following could be used to wrap all getch calls
    # and support window resizes when the getch is blocking
    # all threads.
    #
    def get_ch_handle_signals
      got_input = false
      until got_input
        begin
          c = getch
          got_input = true
        rescue NoMethodError
          # Assuming a SIGWINCH occurred -- reposition..
          c = ''
        end
      end

      c
    end

  end



end
