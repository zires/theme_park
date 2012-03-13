# encoding: utf-8
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

  # Setup and return itself.
  def self.setup
    yield config if block_given?
    self
  end

  class << self

    delegate :root, :prefix, :to => :config

    def config
      @@config ||= ThemePark::Configuration.new
    end

    def version
      ThemePark::Version::STRING
    end

    # Return the path of given theme name.
    def path(theme_name)
      File.join root, theme_name
    end

    def exist?(theme_name)
      Dir.exist? path(theme_name)
    end

    def interpolate(pattern, theme_name)
      pattern.gsub(":root", ThemePark.root).gsub(":name", theme_name.to_s)
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
    def theme_assets_path(theme_name)
      [ images_path(theme_name), javascripts_path(theme_name), stylesheets_path(theme_name) ]
    end

    # The assets path contains all themes' images, javascripts and stylesheets path.
    def assets_path
      Dir.glob( File.join(self.root, "*") ).map do |theme_name|
        theme_name = File.basename(theme_name)
        theme_assets_path(theme_name)
      end.flatten
    end

  end

end

require 'theme_park/railtie' if defined?(Rails)