# encoding: utf-8
module ThemePark
  
  class Configuration
    
    # It is the base path for putting themes folder.
    # For example in rails application is:
    # === 
    # Rails.root
    attr_accessor :base

    # It is the root path for putting each theme folder.
    # usual is:
    # ===
    # /themes
    attr_accessor :root

    # The prefix is used to mount route.
    attr_accessor :prefix

    # The place contains images, javascripts, stylesheets, compiled files and view files.
    attr_accessor :images_path, :javascripts_path, :stylesheets_path, :compiled_path, :views_path

    # Handlers.
    # In some scenes, we may want only one or several handlers.
    attr_accessor :handlers

    def initialize
      # Default settings
      @base             = ''
      @handlers         = :all
      @root             = '/themes'
      @prefix           = 'themes'
      @images_path      = ':root/:name/assets/images'
      @javascripts_path = ':root/:name/assets/javascripts'
      @stylesheets_path = ':root/:name/assets/stylesheets'
      @compiled_path    = ':root/:name/assets/compiled'
      @views_path       = ':root/:name/views'
    end

    def base_root
      File.join(base, root).chomp('/')
    end

  end

end