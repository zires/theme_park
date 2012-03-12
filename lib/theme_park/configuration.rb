# encoding: utf-8
module ThemePark
  
  class Configuration
    
    # It is the root path for putting theme folders.
    # In rails application, usual is "#{Rails.root}/themes/".
    attr_accessor :root
    
    def root
      @root.chomp('/')  
    end

    # The prefix is used to mount route.
    attr_accessor :prefix

    # The place contains images, javascripts, stylesheets, compiled files and view files.
    attr_accessor :images_path, :javascripts_path, :stylesheets_path, :compiled_path, :views_path

  end

end