#!/usr/bin/env ruby
require_relative '../../lib/ppcurses.rb'

@app = PPCurses::Application.new
@table_view = PPCurses::TableView.new

values = [ ["true", "crossfit"],
           ["false", "reading"],
		   ["true",  "music"]
         ]
data_source = PPCurses::MultipleColumnDataSource.new(values)

@table_view.data_source=data_source

@app.content_view = @table_view

@app.launch