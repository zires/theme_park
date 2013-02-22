require 'sprockets/helpers'

module ThemePark
  module Rails
    module AssetTagHelper
      extend ActiveSupport::Concern

      include Sprockets::Helpers 
      
      def current_theme
        @current_theme
      end

      private

      def asset_environment
        if current_theme
          ThemePark.assets(current_theme)
        else
          super
        end
      end

      def asset_prefix
        if current_theme
          "#{ThemePark.prefix}/#{current_theme}"
        else
          super
        end
      end
    end
  end
end
