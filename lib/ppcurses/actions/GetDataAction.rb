require "curses"

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

  def winPadding()
    return 2
  end

  def winWidth()
    Curses.cols - winPadding()
  end

  def winHeight()
    Curses.lines - winPadding()
  end

  def createWindow()
    @win = Window.new( winHeight(), winWidth(), 
                       winPadding()/2, winPadding()/2)

    # Assign window to actions
    unless @actions.nil?
      @actions.each  do |action|
         action.setWindow(@win)
      end
    end
    @win.clear
    @win.box("|", "-")
  end

  def execute()
    createWindow()
    echo

    y = @win.cury + 1
    @win.setpos(y,winPadding())

    self.beforeActions()
    
    @actions.each  do |action|
      action.execute
      #y = @win.cury + 1
      #@win.setpos(y,winPadding())
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

    @win.addstr("Proceed? ")
    echo
    c = @win.getch()
    noecho

    if c == "y" or c == "Y" then
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

