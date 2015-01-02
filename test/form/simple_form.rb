#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

@app = PPCurses::Application.new

def handle_cancel
  @app.terminate
  @pressed_cancel = true
end

def handle_submit
  @app.terminate
  @pressed_submit = true
end


form = PPCurses::Form.new

first_name = PPCurses::InputElement.new('First Name', 10)
last_name = PPCurses::InputElement.new(' Last Name', 10)
age = PPCurses::InputElement.new_integer_only('      Age', 5)

gender = PPCurses::RadioButtonGroup.new('      Sex', %w(Male Female))
button_pair = PPCurses::ButtonPair.new('Submit', 'Cancel')

button_pair.button1.action = method(:handle_submit)
button_pair.button2.action = method(:handle_cancel)

form.add(first_name)
form.add(last_name)
form.add(age)
form.add(gender)
form.add(button_pair)



@app.content_view = form
@app.launch

if @pressed_cancel
  puts 'The user pressed cancel.'
end

if @pressed_submit
  puts 'The user pressed submit.'
end