#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'




def display_form(screen)

  form = PPCurses::Form.new(screen)

  state_box = PPCurses::ComboBox.new('State',
                                     ['Maine', 'New York', 'Kansas', 'California'])

  form.add(state_box)

  form.handle_input

  { state_selected: state_box.object_value_of_selected_item,
    form_submitted: form.submitted?}
end




screen = PPCurses::Screen.new
form_response = screen.run { display_form(screen) }

puts 'Form response data: '
puts form_response

