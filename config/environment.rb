# Hace require de los gems necesarios.
# Revisa: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

# Require gem of twitter
require 'twitter'
require 'yaml'
require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Configura los controllers y los helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }

yaml = YAML.load(File.open("config/twitter.yml"))
# Configura la base de datos y modelos 
require APP_ROOT.join('config', 'database')

CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key        = yaml["consumer_key"]
    config.consumer_secret     = yaml["consumer_secret"]
    config.access_token        = yaml["access_token"]
    config.access_token_secret = yaml["access_token_secret"]
end
