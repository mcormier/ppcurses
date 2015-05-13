#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

@count = 0
def select_counter ( notification )
  @count += 1
end

@app = PPCurses::Application.new

table_view = PPCurses::TableView.new

values = %w(Music Reading Lifts)
data_source = PPCurses::SingleColumnDataSource.new(values)

table_view.data_source=data_source

@app.content_view = table_view

note_centre = PPCurses::NotificationCentre.default_centre

note_centre.add_observer(self, method(:select_counter),  PPTableViewSelectionDidChangeNotification, table_view )

@app.launch

puts "Number of selection changes is: #{@count} "