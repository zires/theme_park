# encoding: utf-8
module ThemePark
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
          path = ThemePark.views_path(name)
          if options.empty?
            prepend_view_path path
          else
            before_filter(options) do |controller|
              controller.prepend_view_path path
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
        path = ThemePark.views_path(name)
        prepend_view_path path
      end
      
    end
  end
end