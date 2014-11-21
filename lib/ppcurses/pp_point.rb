module PPCurses


  # TODO REMOVE PP
  class PPPoint

    attr_accessor :x, :y

    def initialize( x, y )
      @x = x
      @y = y
    end


    def PPPoint.zeroPoint
      PPPoint.new(0,0)
    end

  end

end
