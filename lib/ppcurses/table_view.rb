
PPTableViewSelectionDidChangeNotification = 'PPTableViewSelectionDidChangeNotification'

module PPCurses

 

# Based loosely on ...
#
# https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSTableView_Class/index.html#//apple_ref/occ/cl/NSTableView
#
#
class TableView < View

 
  attr_accessor :data_source
  attr_reader   :selected_row



  # A data source must implement a formal protocol
  #
  # - def number_of_rows_in_table(tableView)
  # - def object_value_for(tableView, tableColumn, rowIndex)
  #
  def data_source=(val)
    PPCurses.implements_protocol( val, %w(number_of_rows_in_table object_value_for ))
    @data_source = val
    @selected_row = 0
  end

  def display(screen)
    y = 2
    x = 2
    for i in 0..@data_source.number_of_rows_in_table(self)
      screen.setpos(y,x)
      screen.attron(Curses::A_REVERSE) if i == selected_row
      screen.addstr(@data_source.object_value_for(self, 0, i) )
      screen.attroff(Curses::A_REVERSE) if i == selected_row
      y += 1
    end
  end


  #  NSTableViewSelectionDidChangeNotification
  #  NSNotificationCentre 
  def key_down( key )
      
      notary = NotificationCentre.default_centre
      
      if key == KEY_DOWN
        @selected_row += 1
        if @selected_row > @data_source.number_of_rows_in_table(self) - 1 then
          @selected_row = 0
        end
        notary.post_notification(PPTableViewSelectionDidChangeNotification, self)        
      end
      
      if key == KEY_UP
         @selected_row -= 1
         if @selected_row < 0 then @selected_row = @data_source.number_of_rows_in_table(self) - 1 end
         notary.post_notification(PPTableViewSelectionDidChangeNotification, self)
      end
      
  end
  
end


# Based on ...
#
# https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Protocols/NSTableDataSource_Protocol/index.html#//apple_ref/occ/intf/NSTableViewDataSource

class SingleColumnDataSource

  def initialize(values)
    @values = values
  end
  
  # Returns the number of records managed for aTableView by the 
  # data source object.
  def number_of_rows_in_table( aTableView)
    @values.length
  end
  
  # Called by the table view to return the data object associated with 
  # the specified row and column.
  def object_value_for(aTableview, column, row_index)
    @values[row_index]
  end
end



class TableViewDataSource

  def TableViewDataSource.from_string_array(values)
    SingleColumnDataSource.new(values)
  end

end



end
