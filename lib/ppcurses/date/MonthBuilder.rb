
def group(xs, n)
    (0..xs.size / n - 1).collect { |i| xs[i * n, n] }     #  / This comment fixes a Visual Studio Code highlighting bug
end

# This algorithm is based on ref/cal.rb by Tadayoshi Funaba
#
# Differences:
# - Only supports a monthly calendar type; no yearly calendar.
#
# - Returns a secondary day position array that specifies the row 
#     and column for each day of the month. Useful for highlighting a
#     specific day 
#
# - Takes a Date object as initial parameter
#
# - K variable eliminated
#
def pict(day)

  year = day.year
  month = day.month

  dw = 2                    # Day width
  mw = (dw + 1) * 7 - 1     # Month width
  
  #d = (1..31).detect{|x| Date.valid_date?(year, month, x, Date::GREGORIAN)}
  
  #puts d
     
  fi = Date.new(year, month, 1, Date::GREGORIAN)      # 2015-05-01
  fi -= (fi.jd + 1) % 7                               # 2015-04-29
    
  ve  = (fi..fi +  6).collect{ |cu|
    %w(S M Tu W Th F S)[cu.wday]
  }
  ve += (fi..fi + 41).collect{ |cu|
    if cu.mon == month then cu.send(:mday) end.to_s
  }
  
  ve = ve.collect{|e| e.rjust(dw)}                              # Creates an array of values ["S", " M", ... "31"]

  gr = group(ve, 7)                                              # Creates an array of arrays.  7 for the days in the week  
  ta = gr.collect{|xs| xs.join(' ')}                             # Converts inner arrays to strings
  
  # Adds month/year header to top 
  ca = %w(January February March April May June July
	        August September October November December)[month - 1]
  ca = ca + ' ' + year.to_s 
  ca = ca.center(mw)    
  ta.unshift(ca)                                                

  
  #puts ta
  # ------------ Currently mocked ------------------------

       # Use nil so we can hava 1 based indexed array.
     day_pos = [ nil, [2,16], [2,19], 
                  [3,1], [3,4], [3,7], [3,10], [3,13], [3,16], [3,19],
                  [4,0], [4,3], [4,6], [4,9],  [4,12], [4,15], [4,18],
                  [5,0], [5,3], [5,6], [5,9],  [5,12], [5,15], [5,18],
                  [6,0], [6,3], [6,6], [6,9],  [6,12], [6,15], [6,18],
                  [7,0] ]
                  
  return ta, day_pos                   
end



module PPCurses


  # A container object that holds:
  #
  # - A date object
  # - The month the day belongs to in string array format
  # - The row and column position of the date in the string array
  #
  # This container is used for displaying dates in the datepicker.
  # The row and column position are necessary so that the day
  # selected can be highlighted.
  #
  class MonthDisplayForDay
  
    attr_accessor :day
    attr_accessor :month_str_array    
    attr_accessor :day_pos
 
    def initialize(day=Date.today)    
      @day = day     
      @day = Date.new(2015, 1, 10)   
      @month_str_array, @day_pos = pict(@day)
    end
  
    def day_row
      @day_pos[ @day.day ][0]
    end
    
    def day_col
      @day_pos[ @day.day ][1]
    end
  
  end


end