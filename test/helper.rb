# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'test/unit'
require 'minitest/autorun'

# Enable turn if it is available
begin
  require 'turn'
rescue LoadError
end

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# $LOAD_PATH.unshift(File.dirname(__FILE__))
# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
# require 'theme_park'

class TestCase < MiniTest::Unit::TestCase
  
  def setup
    @logic_path = File.dirname(__FILE__)
    ThemePark.setup do |config|
      config.root             = "#{@logic_path}/themes/"
      config.prefix           = 'themes'
      config.images_path      = ':root/:name/assets/images'
      config.javascripts_path = ':root/:name/assets/javascripts'
      config.stylesheets_path = ':root/:name/assets/stylesheets'
      config.compiled_path    = ':root/:name/assets/compiled'
      config.views_path       = ':root/:name/views'
    end
  end

  def teardown
  end
  
end
