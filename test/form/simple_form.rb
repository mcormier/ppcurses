#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'




def display_form
  form = PPCurses::Form.new(Curses)

  first_name = PPCurses::InputElement.new('First Name', 10)
  last_name = PPCurses::InputElement.new('Last Name', 10)

  gender = PPCurses::RadioButtonGroup.new('Sex', ['Male', 'Female'])

  form.add(first_name)
  form.add(last_name)
  form.add(gender)

  form.handle_input

  { first_name: first_name.value, last_name: last_name.value, form_submitted: form.submitted?}
end




screen = PPCurses::Screen.new
form_response = screen.run { display_form }

puts 'Form response data: '
puts form_response

