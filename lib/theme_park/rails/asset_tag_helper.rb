# encoding: utf-8
module ThemePark
  module Rails
    module AssetTagHelper
      extend ActiveSupport::Concern

      #include Sprockets::Helpers::RailsHelper

      #
      def theme_stylesheet_link_tag(*sources)
        options = sources.extract_options!
        theme   = options.delete(:theme)
        if serve_static_assets? or !sprockets?
          sources.collect do |source|
            stylesheet_link_tag theme_compiled_path(source, theme)
          end.join("\n").html_safe
        else
          stylesheet_link_tag(*sources)
        end
      end

      #
      def theme_javascript_include_tag(*sources)
        options = sources.extract_options!
        theme   = options.delete(:theme)
        if serve_static_assets? or !sprockets?
          sources.collect do |source|
            javascript_include_tag theme_compiled_path(source, theme)
          end.join("\n").html_safe
        else
          javascript_include_tag(*sources)
        end
      end

      # 
      def theme_image_tag(source, theme = nil, options = {})
        if serve_static_assets? or !sprockets?
          image_tag(theme_compiled_path(source, theme), options)
        else
          image_tag(source, options)
        end
      end

      def theme_compiled_path(source, theme)
        "/#{ThemePark.prefix}/#{theme}/#{source}"
      end

      # sprocket assets pipeline enabled or not.
      def assets_enabled?
        Rails.application.config.assets.enabled
      end

      # serve static assets or not.
      def serve_static_assets?
        Rails.application.config.serve_static_assets
      end

      # use sprockets or not.
      def sprockets?
        assets_enabled? && Rails.application.config.assets.digest.present?
      end

    end
  end
end