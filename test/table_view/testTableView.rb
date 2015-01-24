#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

@app = PPCurses::Application.new

table_view = PPCurses::TableView.new

values = %w(Music Reading Lifts)
data_source = PPCurses::SingleColumnDataSource.new(values)

table_view.data_source=data_source

@app.content_view = table_view
@app.launch