# encoding: utf-8
require 'fileutils'

begin
  require File.join(::Rails.root, 'config', 'initializers', 'theme_park.rb')
rescue Exception => e
end

module ThemePark
  module Generators
    class CreateGenerator < ::Rails::Generators::Base
      # Create a new theme under theme_park root path.
      source_root File.expand_path("../../templates", __FILE__)
      argument :name, :type => :string

      #class_option :force, :type => :boolean, :default => false, :alias => :f, :description => "Will cover exist files."

      desc "Create an empty theme under theme_park root path."
      def create_theme
        ThemePark.theme_assets_path(name).each do |path|
          FileUtils.mkdir_p path
        end
        FileUtils.mkdir_p ThemePark.views_path(name)
        FileUtils.mkdir_p ThemePark.compiled_path(name)

        copy_file "application.css", File.join( ThemePark.stylesheets_path(name), "#{name}.css" )
        copy_file "application.js",  File.join( ThemePark.javascripts_path(name), "#{name}.js" )
        directory "layouts",         File.join( ThemePark.views_path(name), "layouts" )
      end

    end
  end
end