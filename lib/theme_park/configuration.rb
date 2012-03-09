# encoding: utf-8
module ThemePark
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
  class Configuration
    
    attr_reader   :root
    attr_accessor :prefix

    def initialize(root, &block)
      # It is the root path for putting theme folders.
      # In rails application, usual is "#{Rails.root}/themes/".
      @root = root
      yield if block_given?
    end

  end

end