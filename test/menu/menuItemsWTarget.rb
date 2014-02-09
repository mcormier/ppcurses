#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

class Receiver

  attr_accessor :count

  def initialize
    @count = 0
  end

  def receive_message(menu_item)
   @count = @count + 1
  end

end

def display_menu

  # The Receiver class will count every time it receives a message
  # when the space bar is pressed on a menu item.

  item1 = PPCurses::MenuItem.new('Item 1')
  item1.selectable=true
  item1.target=@receiver.method(:receive_message)
  item2 = PPCurses::MenuItem.new('Item 2')
  item2.selectable=true
  item2.target=@receiver.method(:receive_message)
  item3 = PPCurses::MenuItem.new('Item 3')
  item3.selectable=true
  item2.target=@receiver.method(:receive_message)

  main_menu = PPCurses::Menu.new( [ item1, item2, item3], nil )
  main_menu.show
  main_menu.menu_selection
  main_menu.close
end

@receiver = Receiver.new

screen = PPCurses::Screen.new
screen.run { display_menu }

puts 'count=  '  + @receiver.count.to_s

