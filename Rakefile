# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap'
require 'bubble-wrap-http'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'login_app'

  app.identifier = 'com.firstdoman.firstapp'
  app.codesign_certificate = 'iPhone Developer: William Kenrick (Y5NZ3V5728)'
  app.provisioning_profile = '/Users/paulkenrick/Projects/personal/login_test/login_app/firstprofile.mobileprovision'
end
task :"build:simulator" => :"schema:build"
