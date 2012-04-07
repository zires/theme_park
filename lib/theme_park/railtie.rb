# encoding: utf-8
module ThemePark
  class Railtie < ::Rails::Railtie
    
    rake_tasks do
      load "tasks/theme_park.rake"
    end

    generators do
      require "generators/theme_park/install_generator"
      require "generators/theme_park/create_generator"
    end

    initializer "ThemePark.environment", :group => :all do |app|

      config = app.config
      
      config.theme_park = ThemePark.setup do |config|
        config.base = ::Rails.root
      end

      ActiveSupport.on_load(:action_view) do
        include ThemePark::Rails::AssetTagHelper
      end

      ActiveSupport.on_load(:action_controller) do
        include ThemePark::Rails::ActionController
      end

      config.to_prepare do
        # append assets path if enabled
        if config.assets.enabled
          ThemePark.assets_path.each do |path|
            config.assets.paths << path
          end
        end
      end #config.to_prepare

      config.after_initialize do |app|
        # If rails's static asset server is disabled.
        # We will not mount routes
        if config.serve_static_assets
          app.routes.prepend do
            mount ThemePark::Rails::Server.new(app, config.static_cache_control) => "#{ThemePark.prefix}/:theme_name"
          end
        end
      end #config.after_initialize

    end #initializer

  end #Railtie
end #ThemePark