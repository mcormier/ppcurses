require 'ppcurses/actions/BaseAction.rb'

module PPCurses

  class InsertSQLDataAction < GetDataAction

    def initialize( actions, sql, db )
      super(actions)
      @sql = sql
      @db = db
    end

    def winHeight()
       return 7 + @actions.length
    end

    def afterActions()
      preparedSql = @sql
      @actions.each do |action|
        preparedSql = preparedSql.sub("%s", action.data)
      end

      self.promptToChangeData(preparedSql)
    end

  end

end
