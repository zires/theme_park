# encoding: utf-8
require 'fileutils'

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
        copy_file "application.css", File.join( relative_path(ThemePark.stylesheets_path(name)), "#{name}.css" )
        copy_file "application.js", File.join( relative_path(ThemePark.javascripts_path(name)), "#{name}.js" )
        directory "layout", relative_path( ThemePark.views_path(name) )
      end

      private
      ##
      # '/var/www/{Your-app}/themes/...' #=> '/themes/...'
      def relative_path(path)
        path =~ /#{Rails.root}(.*)/
        $1
      end

    end
  end
end