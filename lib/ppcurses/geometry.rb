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

  end

# -------------------------------------------------------------------

  class Size
    attr_accessor :width, :height
    
    def initialize( width, height )
      @width = width
      @height = height
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
   
  end

end
