# encoding: utf-8
module ThemePark
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      # Create theme_park.rb under config/initializers/
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a ThemePark initializer file."
      def copy_initializer
        template "theme_park.rb", "config/initializers/theme_park.rb"
      end

    end
  end
end
  