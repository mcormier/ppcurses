#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


class MyDelegate

  def applicationDidFinishLaunching( app )

  end

end



delegate = MyDelegate.new

app = PPCurses::Application.new
app.set_delegate(delegate)
app.launch


