#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


class String
	def black;          "\033[30m#{self}\033[0m" end
	def red;            "\033[31m#{self}\033[0m" end
	def green;          "\033[32m#{self}\033[0m" end
	def brown;          "\033[33m#{self}\033[0m" end
	def blue;           "\033[34m#{self}\033[0m" end
	def magenta;        "\033[35m#{self}\033[0m" end
	def cyan;           "\033[36m#{self}\033[0m" end
	def gray;           "\033[37m#{self}\033[0m" end
	def bg_black;       "\033[40m#{self}\033[0m" end
	def bg_red;         "\033[41m#{self}\033[0m" end
	def bg_green;       "\033[42m#{self}\033[0m" end
	def bg_brown;       "\033[43m#{self}\033[0m" end
	def bg_blue;        "\033[44m#{self}\033[0m" end
	def bg_magenta;     "\033[45m#{self}\033[0m" end
	def bg_cyan;        "\033[46m#{self}\033[0m" end
	def bg_gray;        "\033[47m#{self}\033[0m" end
	def bold;           "\033[1m#{self}\033[22m" end
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





