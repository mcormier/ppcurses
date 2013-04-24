require_relative 'BaseAction.rb'

module PPCurses


# An action that contains an array of prompt actions.  
# It can be used to group together multiple prompt actions.
#
class GetDataAction < BaseAction

  def initialize( actions )
    @actions = actions
    unless @actions.nil?
      @actions.each  do |action|
         action.setParentAction(self)
      end
    end
  end

  def beforeActions()
    # Stub for classes that extend
  end

  def afterActions()
    # Stub for classes that extend
  end


  def data()
    values = []
    @actions.each  do |action|
       values.push(action.data())
    end
    return values
  end

  def createWindow()
    super()
    # Assign window to actions
    unless @actions.nil?
      @actions.each  do |action|
         action.setWindow(@win)
      end
    end
  end

  def execute()
    createWindow()
    echo

    @win.setpos(@win.cury,xPadding())

    self.beforeActions()
    
    @actions.each  do |action|
      action.execute
    end

    self.afterActions()

    noecho
    @win.clear 
    @win.refresh
    @win.close
  end

  def printLine(string)
    @win.setpos(@win.cury(), winPadding())
    @win.addstr(string)
    @win.setpos(@win.cury() + 1, winPadding())
  end

  def printSuccessLine(string)
    init_pair(1, COLOR_GREEN, COLOR_BLACK)
    @win.attron(color_pair(1))
    self.printLine(string)
    @win.attroff(color_pair(1))
  end

  def printErrorLine(string)
    init_pair(1, COLOR_RED, COLOR_BLACK)
    @win.attron(color_pair(1))
    self.printLine(string)
    @win.attroff(color_pair(1))
  end

  def promptToChangeData(preparedSQL)
    self.printLine(preparedSQL)

    proceed = GetBooleanAction.new("Proceed? ")
    proceed.setParentAction(self)
    proceed.setWindow(@win)
    proceed.execute()

    if proceed.data == "1" then
      self.printLine("")
      begin
        @db.execute preparedSQL
        self.printSuccessLine("Execution successful")
      rescue SQLite3::Exception => e
        self.printErrorLine("Exception occurred")
        self.printErrorLine(e.message)
      ensure
        self.printLine("")
        self.printLine("< Press any key to continue > ")
        @win.getch()
      end
      
    end


  end

end

end 

