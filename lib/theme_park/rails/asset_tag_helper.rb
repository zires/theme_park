# encoding: utf-8
module ThemePark
  module Rails
    module AssetTagHelper
      extend ActiveSupport::Concern

      # if theme option is nil, it will use current_theme.
      # ===
      # Usage:
      #   theme_stylesheet_link_tag application, :theme => 'dark'
      # 
      def theme_stylesheet_link_tag(*sources)
        options = sources.extract_options!
        theme   = options.delete(:theme) || current_theme
        if serve_theme_compiled?
          sources.collect do |source|
            stylesheet_link_tag theme_compiled_path(source, theme)
          end.join("\n").html_safe
        else
          stylesheet_link_tag(*sources)
        end
      end

      def theme_javascript_include_tag(*sources)
        options = sources.extract_options!
        theme   = options.delete(:theme) || current_theme
        if serve_theme_compiled?
          sources.collect do |source|
            javascript_include_tag theme_compiled_path(source, theme)
          end.join("\n").html_safe
        else
          javascript_include_tag(*sources)
        end
      end

      def theme_image_tag(source, options = {})
        theme = options.delete(:theme) || current_theme
        if serve_theme_compiled?
          image_tag(theme_compiled_path(source, theme), options)
        else
          image_tag(source, options)
        end
      end

      # Get the right path to theme compiled directory.
      def theme_compiled_path(source, theme = nil)
        theme = theme || current_theme
        "/#{ThemePark.prefix}/#{theme}/#{source}"
      end

      # sprocket assets pipeline enabled or not.
      def assets_enabled?
        ::Rails.application.config.assets.enabled
      end

      # serve static assets or not.
      def serve_static_assets?
        ::Rails.application.config.serve_static_assets
      end

      # use sprockets or not.
      def assets_digest?
        ::Rails.application.config.assets.digest
      end

      # Decide to serve static files under theme compiled directory or not.
      def serve_theme_compiled?
        serve_static_assets? and assets_digest?
      end

      # In some use case, you may need to override this method.
      def current_theme
        @current_theme
      end

    end
  end
end