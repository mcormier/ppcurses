require_relative 'BaseAction.rb'

module PPCurses

  class InsertSQLDataAction < GetDataAction

    def initialize( actions, sql, db )
      super(actions)
      @sql = sql
      @db = db
      @prepStatement = db.prepare(sql)
    end

    def winHeight()
      8 + @actions.length
    end

    def afterActions()
      preparedSql = @sql
      dataArray = []

      @actions.each do |action|
        preparedSql = preparedSql.sub('?', action.data)
        dataArray.push(action.data)
      end

      self.promptToChangeData(preparedSql, dataArray)
      
    end

    def promptToChangeData(userDisplaySQL, dataArray)
      self.printLine(userDisplaySQL)

      proceed = GetBooleanAction.new('Proceed? ')
      proceed.setParentAction(self)
      proceed.setWindow(@win)
      proceed.execute()

      if proceed.data == '1' then
        self.printLine('')
        begin
          @prepStatement.bind_params(dataArray)
          @prepStatement.execute()
          @prepStatement.close()
          self.printSuccessLine('Execution successful')
        rescue SQLite3::Exception => e
          self.printErrorLine('Exception occurred')
          self.printErrorLine(e.message)
        ensure
          self.printLine('')
          self.printLine('< Press any key to continue > ')
          @win.getch()
        end

      end


    end

  end

end
