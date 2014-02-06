# -*- encoding : utf-8 -*-

module PPCurses

  PP_MIXED_STATE = -1
  PP_OFF_STATE = 0
  PP_ON_STATE = 1

  SELECTED_CHAR = '✓'

  class MenuItem
    attr_accessor :title
    attr_accessor :action
    attr_accessor :state

    def initialize( title )
      @title = title
      @state = PP_OFF_STATE
    end

    def display_string
      if @state == PP_OFF_STATE
        return '  ' + @title
      end

      SELECTED_CHAR + ' ' + @title
    end

  end

end
