#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'




  form = PPCurses::Form.new

  first_name = PPCurses::InputElement.new('First Name', 10)
  last_name = PPCurses::InputElement.new(' Last Name', 10)
  age = PPCurses::InputElement.new_integer_only('      Age', 5)

  gender = PPCurses::RadioButtonGroup.new('      Sex', %w(Male Female))

  form.add(first_name)
  form.add(last_name)
  form.add(age)
  form.add(gender)



app = PPCurses::Application.new
app.content_view = form

app.launch