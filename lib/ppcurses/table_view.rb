
PPTableViewSelectionDidChangeNotification  = 'PPTableViewSelectionDidChangeNotification'
PPTableViewSelectionIsChangingNotification = 'PPTableViewSelectionIsChangingNotification'
PPTableViewEnterPressedNotification        = 'PPTableViewEnterPressedNotification'

module PPCurses

 

# Based loosely on ...
#
# https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSTableView_Class/index.html#//apple_ref/occ/cl/NSTableView
#
#
class TableView < View

 
  attr_accessor :data_source
  attr_reader   :selected_row

  def initialize
    super
    origin = Point.new( 2, 2 )
    setFrameOrigin(origin)
    
    @table_columns = []
  end


  # A data source must implement a formal protocol
  #
  # - def number_of_rows_in_table(tableView)
  # - def object_value_for(tableView, tableColumn, rowIndex)
  #
  def data_source=(val)
    PPCurses.implements_protocol( val, %w(number_of_rows_in_table object_value_for ))
    @data_source = val
    @selected_row = 0
    
    # Determine frame size from datasource data
    height = @data_source.number_of_rows_in_table(self)
    width = 0    
    for i in 0..@data_source.number_of_rows_in_table(self)-1
      x = @data_source.object_value_for(self, 0, i).length
      if x > width then width = x end
    end
    
    # Add an extra line for the column header
    # and ====== divider 
    height += 2
    
    sz = Size.new( width, height )
    setFrameSize( sz )
    
  end

  def display(screen)
    
    y = @frame.origin.y
    x = @frame.origin.x
    
    j = number_of_columns
    
    # display column header
    screen.setpos(y,x)
    @table_columns.each_with_index do |column, i|
      screen.addstr(column.identifier.center(column.width))
      if i <  @table_columns.length - 1 then screen.addstr('|') end
    end
    
    y += 1
    screen.setpos(y,x)
    # Display ================= divider
    @table_columns.each do |column|
      screen.addstr( ''.center(column.width, '=') )      
    end
    
    y += 1
    
    for i in 0..@data_source.number_of_rows_in_table(self)-1
      screen.setpos(y,x)
      screen.attron(Curses::A_REVERSE) if i == selected_row
      for k in 0..j-1
        if k > 0 then
          screen.addstr(' | ')
        end
        screen.addstr(@data_source.object_value_for(self, k, i) )
      end
      screen.attroff(Curses::A_REVERSE) if i == selected_row
      y += 1
    end
  end


  #  NSTableViewSelectionDidChangeNotification
  #  NSNotificationCentre 
  def key_down( key )
      
      notary = NotificationCentre.default_centre
      
      if key == KEY_DOWN        
        notary.post_notification(PPTableViewSelectionIsChangingNotification, self) 
        @selected_row += 1
        if @selected_row > @data_source.number_of_rows_in_table(self) - 1 then
          @selected_row = 0
        end
        notary.post_notification(PPTableViewSelectionDidChangeNotification, self)        
      end
      
      if key == KEY_UP
         notary.post_notification(PPTableViewSelectionIsChangingNotification, self) 
         @selected_row -= 1
         if @selected_row < 0 then @selected_row = @data_source.number_of_rows_in_table(self) - 1 end
         notary.post_notification(PPTableViewSelectionDidChangeNotification, self)
      end
      
      if key == ENTER
        notary.post_notification(PPTableViewEnterPressedNotification, self) 
      end
      
      
  end
  
  def number_of_columns
    num_col = 0
    
    while @data_source.object_value_for(self, num_col, 0) != nil do
      num_col += 1
    end
    
    
    num_col
  end
  
  ## Column Management
  
  def add_table_column( col )
    col.table_view = self
    @table_columns.push(col)    
  end
  
end

# ==========================================================================================
#
# Based loosely on ...
# https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSTableColumn_Class/index.html#//apple_ref/swift/cl/NSTableColumn
#
#  The TableColumn class stores the display characteristics and identifier for a column
#  in a TableView instance.  A table column object determines the width of its column.
class TableColumn

  attr_accessor :identifier
  attr_accessor :width
  attr_accessor :table_view

  def initialize( identifier, width = 5 )
    @identifier = identifier
    @width = width
  end

end


# ==========================================================================================
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
    if  column > 0 then
      return nil
    end
     
    @values[row_index]
  end
end

# Values in the constructor is expected to be a two sided array
class MultipleColumnDataSource < SingleColumnDataSource
    
  # Called by the table view to return the data object associated with 
  # the specified row and column.
  def object_value_for(aTableview, column, row_index)
    @values[row_index][column]
  end
  
  
end

class TableViewDataSource

  def TableViewDataSource.from_string_array(values)
    SingleColumnDataSource.new(values)
  end

end



end
