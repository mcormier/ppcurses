#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


@app = PPCurses::Application.new

form = PPCurses::Form.new

date_picker = PPCurses::DatePicker.new('Date')
form.add(date_picker)


@app.content_view = form
@app.launch



