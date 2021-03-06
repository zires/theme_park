# Convention over configuration.
# 
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
# Uncomment below lines if you really need to.
# ===
# ThemePark.setup do |config|
#   
#   config.root             = '/themes'
#   config.handlers         = :all           # will load all handlers depends on your application.
#   # other options for handlers
#   # config.handlers       = [:liquid]      # only load .liquid
#   # config.handlers       = [:erb, :haml]  # only load .erb and .haml
#   config.prefix           = 'themes'
#   config.images_path      = ':root/:name/assets/images'
#   config.javascripts_path = ':root/:name/assets/javascripts'
#   config.stylesheets_path = ':root/:name/assets/stylesheets'
#   config.compiled_path    = ':root/:name/assets/compiled'
#   config.views_path       = ':root/:name/views'

# end
# ===