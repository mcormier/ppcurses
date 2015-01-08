#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

@app = PPCurses::Application.new

@win = PPCurses::Window.new(9,60,0,0)

table_view = PPCurses::TableView.new


@app.content_view = table_view
@app.launch

