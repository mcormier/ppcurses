module PPCurses

  class MenuItem
    attr_accessor :title
    attr_accessor :action

    def initialize( title )
      @title = title;
    end

  end

end