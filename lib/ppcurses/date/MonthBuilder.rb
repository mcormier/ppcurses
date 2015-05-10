
def group(xs, n)
    (0..xs.size / n - 1).collect { |i| xs[i * n, n] }     #  / This comment fixes a Visual Studio Code highlighting bug
end

# --------------------------------------------------------------------------
# This algorithm is based on ref/cal.rb by Tadayoshi Funaba
#
# Differences:
# - Only supports a monthly calendar type; no yearly calendar.
#
# - Returns a secondary day position array that specifies the row 
#     and column for each day of the month. Useful for highlighting a
#     specific day. 
#
#     Example day position array for May 2015.  The 1st of February
#     occurs in the second row and the 16th column of the returned
#     string calendar array
#
#     day_pos = [ nil, [2,16], [2,19], 
#                  [3,1], [3,4], [3,7], [3,10], [3,13], [3,16], [3,19],
#                  [4,0], [4,3], [4,6], [4,9],  [4,12], [4,15], [4,18],
#                  [5,0], [5,3], [5,6], [5,9],  [5,12], [5,15], [5,18],
#                  [6,0], [6,3], [6,6], [6,9],  [6,12], [6,15], [6,18],
#                  [7,0] ]
#
#
# - Takes a Date object as initial parameter
#
# - K variable eliminated
#
# - Does not support the transformation option
#
#
def pict(day)

  year = day.year
  month = day.month

  dw = 2                    # Day width
  mw = (dw + 1) * 7 - 1     # Month width
  day_pos = [ nil ]         # Create an array indexed by 1 by putting nil in slot zero.
  
  # First day of the month e.g. 2015-05-01
  fi = Date.new(year, month, 1, Date::GREGORIAN) 
  # Go backwards to the earliest closest day divisible by 7 date, e.g. 2015-04-26, 
  # using the Julian day number and modulus.    
  fi -= (fi.jd + 1) % 7                              
    
  ve  = (fi..fi +  6).collect{ |cu|
    %w(S M Tu W Th F S)[cu.wday]
  }
  
  row = 2
  pos = -1  
  # Creates an array of values ["S", " M", ... "31"]
  ve += (fi..fi + 41).collect{ |cu|  # of type Date
     
     pos += 1 
       
    if cu.mon == month then
       
      # Meta information for day_pos array 
      if (cu.jd + 1) % 7 == 0 then 
        row += 1
        pos = 0 
      end 
      i = pos * 3
      if number < 10 then i += 1 end  
      i = indexFor(pos, cu.mday)      
      day_pos.push [row, i]             
       
      cu.mday  
    end.to_s
    
  }
  
  # adds padding based on day width  "1"  --> " 1"
  ve = ve.collect{|e| e.rjust(dw)}                              

  # Creates an array of arrays.  7 for the days in the week  
  gr = group(ve, 7)    
  
  # Converts inner arrays to strings                                     
  ta = gr.collect{|xs| xs.join(' ')}                            

  # Adds month/year header to top 
  ca = %w(January February March April May June July
	        August September October November December)[month - 1]
  ca = ca + ' ' + year.to_s 
  ca = ca.center(mw)    
  ta.unshift(ca)                                                

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
     # @day = Date.new(2015, 1, 10)   
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