module PPCurses

  class Point

    attr_accessor :x, :y

    def initialize( x=0, y=0 )
      @x = x
      @y = y
    end

    def to_s
      "x=#{@x} y=#{@y}"
    end

    def Point.zeroPoint
      Point.new
    end

  end

# -------------------------------------------------------------------

  class Size
    attr_accessor :width, :height
    
    def initialize( width=0, height=0 )
      @width = width
      @height = height
    end
    
    def Size.zeroSize
      Size.new
    end
    
    def to_s
      "width=#{@width} height=#{@height}"
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
   
    def to_s
      "origin[#{@origin}] size[#{@size}]"
    end
    
  end

end
