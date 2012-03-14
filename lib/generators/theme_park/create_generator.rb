# encoding: utf-8
require 'fileutils'

module ThemePark
  module Generators
    class CreateGenerator < ::Rails::Generators::Base
      # Create a new theme under theme_park root path.
      argument :name, :type => :string

      class_option :force, :type => :boolean, :default => false, :alias => :f, :description => "Will cover exist files."

      desc "Create an empty theme under theme_park root path."
      def create_theme
        ThemePark.theme_assets_path(name).each do |path|
          FileUtils.mkdir_p path
        end
      end

    end
  end
end