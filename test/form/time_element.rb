#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


@app = PPCurses::Application.new

form = PPCurses::Form.new

duration = PPCurses::InputElement.new_time_only(' Duration', 10)


form.add(duration)

@app.content_view = form
@app.launch



