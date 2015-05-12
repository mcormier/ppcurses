module PPCurses
# Based loosely on ...
#
# https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSTableView_Class/index.html#//apple_ref/occ/cl/NSTableView
#
#
class TableView < View

  attr_accessor :data_source


  def selected_row

  end

  # A data source must implement a formal protocol
  #
  # - def number_of_rows_in_table(tableView)
  # - def object_value_for(tableView, tableColumn, rowIndex)
  #
  def data_source=(val)
    PPCurses.implements_protocol( val, %w(number_of_rows_in_table object_value_for ))
    @data_source = val
  end

  def display(screen)
    y = 2
    x = 2
    for i in 0..@data_source.number_of_rows_in_table
      screen.setpos(y,x)
      screen.addstr(@data_source.object_value_for(0,i) )
      y += 1
    end
  end

end


# Based loosely on ...
#
# https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Protocols/NSTableDataSource_Protocol/index.html#//apple_ref/occ/intf/NSTableViewDataSource

class SingleColumnDataSource

  def initialize(values)
    @values = values
  end

  def number_of_rows_in_table
    @values.length
  end

  def object_value_for(column, row_index)
    @values[row_index]
  end
end



class TableViewDataSource

  def TableViewDataSource.from_string_array(values)
    SingleColumnDataSource.new(values)
  end

end



end
