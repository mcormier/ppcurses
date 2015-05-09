#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


class String	
	def reverse_color;  "\033[7m#{self}\033[27m" end
end

cal = PPCurses::MonthDisplayForDay.new

cal.monthStrArray.each_with_index { |val, i| 

  if i != cal.day_row 
    puts val
  else
    num_of_digits = cal.day.day > 9 ? 2 : 1
   
    print val[0, cal.day_col] 
	print val[cal.day_col, cal.day_col + num_of_digits].reverse_color
	puts  val[cal.day_col + num_of_digits + 1] 
  end

}





