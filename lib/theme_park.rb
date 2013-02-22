require 'active_support/core_ext/module/delegation'
# 
# convention over configuration.
#
# Rails application example:
# app/
# - themes
#   - [theme_name]
#     |- assets
#        |- images
#        |- javascripts
#        |- stylesheets
#        |- compiled           -> Compiled static files
#     |- views
#        |- layouts
#   
module ThemePark
  autoload :Configuration, 'theme_park/configuration'
  autoload :Version,       'theme_park/version'
  autoload :Server,        'theme_park/server'

  module Rails
    autoload :ActionController, 'theme_park/rails/action_controller'
    autoload :AssetTagHelper,   'theme_park/rails/asset_tag_helper'
    autoload :Server,           'theme_park/rails/server'
  end

  class << self

    delegate :base, :root, :base_root, :prefix, :handlers, :to => :config

    def config
      @@config ||= ThemePark::Configuration.new
    end

    def setup
      yield config if block_given?
      self
    end

    def env
      @@env ||= Sprockets::Environment.new(base.to_s) do |env|
        env.version = ::Rails.env
        env.cache   = Sprockets::Cache::FileStore.new "#{base}/tmp/cache/assets/#{::Rails.env}"
      end
    end

    def assets(name)
      env.clear_paths
      assets_path(name).each{|path| env.append_path path }
      env
    end

    def version
      ThemePark::Version::STRING
    end

    # Return the path of given theme name.
    def path(theme_name)
      File.join base_root, theme_name
    end

    def exist?(theme_name)
      Dir.exist? path(theme_name)
    end

    def interpolate(pattern, theme_name)
      pattern.gsub(":root", base_root).gsub(":name", theme_name.to_s)
    end
    
    ##
    # :method: images_path
    #
    # :call-seq: images_path(theme_name)
    #
    # Return images path for the theme name

    ##
    # :method: javascripts_path
    #
    # :call-seq: javascripts_path(theme_name)
    #
    # Return javascripts path for the theme name

    ##
    # :method: stylesheets_path
    #
    # :call-seq: stylesheets_path(theme_name)
    #
    # Return stylesheets path for the theme name

    ##
    # :method: compiled_path
    #
    # :call-seq: compiled_path(theme_name)
    #
    # Return compiled file path for the theme name

    ##
    # :method: views_path
    #
    # :call-seq: views_path(theme_name)
    #
    # Return views path for the theme name

    [ :images, :javascripts, :stylesheets, :compiled, :views ].each do |dir|
      class_eval <<-DIR_EVAL, __FILE__, __LINE__ + 1
        
        def #{dir}_path(theme_name) 
          pattern = config.send :#{dir}_path
          interpolate(pattern, theme_name)
        end

      DIR_EVAL
    end

    # The theme assets path is a array contains images, javascripts and stylesheets path.
    def assets_path(name)
      [ images_path(name), javascripts_path(name), stylesheets_path(name) ]
    end

    # The assets path contains all themes' images, javascripts and stylesheets path.
    def all_assets_path
      Dir.glob( File.join(self.base_root, "*") ).map do |theme_name|
        assets_path( File.basename(theme_name) )
      end.flatten
    end

  end

end

require 'theme_park/railtie' if defined?(Rails)
