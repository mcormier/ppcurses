#!/usr/bin/env ruby
require_relative '../../lib/ppcurses.rb'

@app = PPCurses::Application.new
@table_view = PPCurses::TableView.new

values = [ ["true", "crossfit"],
           ["false", "reading"],
		   ["true",  "music"]
         ]

col_a = PPCurses::TableColumn.new('bool')
col_a.width = 6
@table_view.add_table_column(col_a)		 

col_b = PPCurses::TableColumn.new('Activity')
col_b.width = 10
@table_view.add_table_column(col_b)	
		 
data_source = PPCurses::MultipleColumnDataSource.new(values)
@table_view.data_source=data_source

@app.content_view = @table_view

@app.launch