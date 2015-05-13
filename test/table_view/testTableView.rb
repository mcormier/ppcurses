#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'
# ------------------------------------------------------------------------------
# Tableview callbacks
# ------------------------------------------------------------------------------
@select_count = 0
def select_counter ( notification )
  @select_count += 1
end

@enter_count = 0
def item_chosen ( notification )
  @enter_count += 1
  
  if notification.object.selected_row == 0
    @app.content_view = @music_form
  end
  
end
# ------------------------------------------------------------------------------

@music_form = PPCurses::Form.new
media = PPCurses::RadioButtonGroup.new(' Media Type', %w(CD Vinyl MP3) )
buttons = PPCurses::ButtonPair.new('Submit', 'Cancel')
@music_form.add(media)
@music_form.add(buttons)


@app = PPCurses::Application.new
table_view = PPCurses::TableView.new

values = %w(Music Reading Lifts)
data_source = PPCurses::SingleColumnDataSource.new(values)

table_view.data_source=data_source

@app.content_view = table_view

notary = PPCurses::NotificationCentre.default_centre
notary.add_observer(self, method(:select_counter),  PPTableViewSelectionDidChangeNotification, table_view )
notary.add_observer(self, method(:item_chosen),  PPTableViewEnterPressedNotification, table_view )

@app.launch

puts "Number of selection changes was: #{@select_count} "
puts "Enter was pressed #{@enter_count} times."