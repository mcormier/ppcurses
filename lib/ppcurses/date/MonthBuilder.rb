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
    attr_accessor :monthStrArray
    attr_accessor :day_row
    attr_accessor :day_col
 
    def initialize(day)
    
      # TODO - this needs to be dynamic.  Currently hard-coded to may 15th 2015
      @day = Date.new(2015, 5, 9)
      
      @monthStrArray = ["      May 2015      ", 
                        " S  M Tu  W Th  F  S", 
                        "                1  2", 
                        " 3  4  5  6  7  8  9", 
                        "10 11 12 13 14 15 16", 
                        "17 18 19 20 21 22 23", 
                        "24 25 26 27 28 29 30", 
                        "31                  "]
       @day_row = 4
       @day_col = 20

    
    end
    
  
  end


end