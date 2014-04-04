# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
if ENV['osx']
  require 'motion/project/template/osx'
else
  require 'motion/project/template/ios'
end
require './lib/bubble-wrap-http'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'BubbleWrap-HTTP'
end
