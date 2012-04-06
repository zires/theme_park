# encoding: utf-8
module ThemePark
  module Rails
    module AssetTagHelper
      extend ActiveSupport::Concern

      #include Sprockets::Helpers::RailsHelper

      #
      def theme_stylesheet_link_tag(*sources)

      end

      #
      def theme_javascript_include_tag(*sources)
        
      end

      #
      def theme_image_path(source, theme = nil)
        return image_path(source) if theme.blank?
        if serve_static_assets?
          
        end
      end

      # sprocket assets pipeline enabled or not.
      def assets_enabled?
        Rails.application.config.assets.enabled
      end

      # serve static assets or not.
      def serve_static_assets?
        Rails.application.config.serve_static_assets
      end

    end
  end
end