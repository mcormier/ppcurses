#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

begin
  #noinspection RubyResolve
  require 'sqlite3'
rescue LoadError => e
  abort 'Missing dependency! Run: gem install sqlite3'
end

string_action = PPCurses::GetStringAction.new('What is your name? ')
integer_action = PPCurses::GetIntegerAction.new('Input an integer? ')

def do_action(action)
  action.show
  action.execute
end


#noinspection RubyResolve
db = SQLite3::Database.open 'test.db'
db.execute <<-SQL
  create table testTable (name varchar(30), val int);
SQL


sql_action = PPCurses::InsertSQLDataAction.new( [string_action, integer_action],
                                                'Insert into testTable(name, val) values (?, ?)', db)

screen = PPCurses::Screen.new
screen.run { do_action(sql_action) }


db.close
File.delete('test.db')


