#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


@app = PPCurses::Application.new

form = PPCurses::Form.new

state_box = PPCurses::ComboBox.new('State',
                                   ['Maine', 'New York', 'Kansas', 'California'])
form.add(state_box)


@app.content_view = form
@app.launch



