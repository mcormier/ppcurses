# -*- encoding : utf-8 -*-

module PPCurses

  PP_MIXED_STATE = -1
  PP_OFF_STATE = 0
  PP_ON_STATE = 1

  SELECTED_CHAR = '✓'

  class MenuItem
    attr_accessor :title

    # Who to notify when menu is selected chosen?
    # The target should be a method selector, and
    attr_accessor :target

    attr_accessor :state
    attr_accessor :selectable

    def initialize( title )
      @title = title
      @state = PP_OFF_STATE
      @selectable = false
    end

    def display_string
      if @state == PP_OFF_STATE
        return '  ' + @title
      end

      SELECTED_CHAR + ' ' + @title
    end


    def toggle_on_off_state
      if @state == PP_OFF_STATE
        @state = PP_ON_STATE
        return
      end

      if @state == PP_ON_STATE
        @state = PP_OFF_STATE
      end

    end

    def handle_key(key)

      if key == ' ' and @selectable
        toggle_on_off_state
        unless @target.nil?
          @target.call(self)
        end
        return true
      end

      if key == ENTER
        unless @target.nil?
          @target.call(self)
        end
        return true
      end

      false
    end

  end

end
