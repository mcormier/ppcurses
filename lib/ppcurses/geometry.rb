module PPCurses

  class Point

    attr_accessor :x, :y

    def initialize( x, y )
      @x = x
      @y = y
    end

    def to_s
      "x=#{@x} y=#{@y}"
    end

    def Point.zeroPoint
        Point.new( 0, 0 )
    end

  end

# -------------------------------------------------------------------

  class Size
    attr_accessor :width, :height
    
    def initialize( width, height )
      @width = width
      @height = height
    end
    
    def Size.zeroSize
      Size.new ( 0, 0 )
    end
    
  end

# -------------------------------------------------------------------

  class Rect
    attr_accessor :origin, :size
   
    def initialize ( origin, size )
      @origin = origin
      @size = size
    end
   
    def Rect.makeRect( x, y, w, h )
      origin = Point.new(x, y)
      size  = Size.new(w, h)
      
      rect = Rect.new( origin, size)
    end
   
    def Rect.zeroRect
      Rect.new( Point.zeroPoint, Size.zeroSize )
    end
   
  end

end
