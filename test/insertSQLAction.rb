#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'
require 'sqlite3'

stringAction = PPCurses::GetStringAction.new("What is your name? ");
intAction = PPCurses::GetIntegerAction.new("Input an integer? ");

def doAction(action)
  action.show()
  action.execute()
end


db = SQLite3::Database.open "test.db"
db.execute <<-SQL
  create table testTable (name varchar(30), val int);
SQL


sqlAction = PPCurses::InsertSQLDataAction.new( [stringAction, intAction],
                  "Insert into testTable(name, val) values ('%s', %s)", db)

screen = PPCurses::Screen.new()
screen.run { doAction(sqlAction) }

db.close
File.delete("test.db")
