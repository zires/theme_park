# encoding: utf-8
module ThemePark

  # For rails, we need to resolve the handlers.
  def self.resolve_views_path(name)
    views_path = self.views_path(name)
    if ThemePark.handlers.to_s != 'all'
      handers = ThemePark.handlers.to_a.join(',')
      ActionView::FileSystemResolver.new(views_path, ":prefix/:action{.:locale,}{.:formats,}{.{#{handers}},}")
    else
      views_path
    end
  end

  module Rails
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
          path = ThemePark.resolve_views_path(name)
          before_filter(options) do |controller|
            @current_theme = name
            controller.prepend_view_path path
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
        @current_theme = name
        path           = ThemePark.resolve_views_path(name)
        prepend_view_path path
      end
      
    end
  end
end