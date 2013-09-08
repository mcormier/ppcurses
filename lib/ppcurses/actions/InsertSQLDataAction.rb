require_relative 'BaseAction.rb'

module PPCurses

  class InsertSQLDataAction < GetDataAction

    def initialize( actions, sql, db )
      super(actions)
      @sql = sql
      @db = db
    end

    def winHeight()
      8 + @actions.length
    end

    def after_actions
      prepared_sql = @sql
      data_array = []

      @actions.each do |action|
        prepared_sql = prepared_sql.sub('?', action.data)
        data_array.push(action.data)
      end

      self.prompt_to_change_data(prepared_sql, data_array)
      
    end

    #
    # returns true if data was inserted
    #
    def prompt_to_change_data(user_display_sql, data_array)
      self.print_line(user_display_sql)

      proceed = GetBooleanAction.new('Proceed? ')
      proceed.setParentAction(self)
      proceed.set_window(@win)
      proceed.execute()

      did_insert = false

      if proceed.data == '1'
        self.print_line('')
        begin
          prep_statement = @db.prepare(@sql)
          prep_statement.bind_params(data_array)
          prep_statement.execute()
          prep_statement.close()
          did_insert = true
          self.print_success_line('Execution successful')
        rescue SQLite3::Exception => e
          self.print_error_line('Exception occurred')
          self.print_error_line(e.message)
        ensure
          self.print_line('')
          self.print_line('< Press any key to continue > ')
          @win.getch()
        end

      end

      did_insert
    end

  end

end
