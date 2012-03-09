# encoding: utf-8
module ThemePark
  module ActionController
    extend ActiveSupport::Concern

    module ClassMethods
      # Example:
      # ===
      # class MyController < ApplicationController
      #   theme "dark", :only => :index
      # end
      # ===
      def theme(name, options = {})
        if options.empty?
          prepend_view_path path
          # Assets if use sprockets
          if Rails.application.config.assets.enabled
            Rails.application.assets.paths << theme_asset_path_for(theme_name) unless Rails.application.assets.paths.include?(theme_asset_path_for(theme_name))
          end
          # resolve asset path if not use sprockets
        else
          before_filter(options) do |controller|
            controller.theme(name)
          end
        end
      end

    end

    private
    # Example:
    # ===
    # class MyController < ApplicationController
    #   def index
    #     theme 'dark'
    #   end
    # end
    # ===
    def theme(name)
      prepend_view_path path
    end

  end
end