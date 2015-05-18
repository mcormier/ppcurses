#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


@app = PPCurses::Application.new

form = PPCurses::Form.new

km = PPCurses::InputElement.new_decimal_only(' Decimal Number', 10)
age = PPCurses::InputElement.new_integer_only('      Integer', 5)

form.add(km)
form.add(age)

@app.content_view = form
@app.launch



