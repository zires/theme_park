# Precompile your asset source file in compiled folder.
# Usage:
#   rake theme_park:precompile theme=dark
# if theme_name not given, it will precompile all themes.
namespace :theme_park do
  
  desc "Precompile your asset source file in compiled folder"
  task :precompile => :environment do
    
    unless ::Rails.application.config.assets.enabled
      warn "Cannot precompile assets if sprockets is disabled. Please set config.assets.enabled to true"
      exit
    end

    theme    = ENV["theme"]
    env      = ::Rails.application.assets

    themes = if theme
      [ theme ]
    else
      Dir.glob( File.join(ThemePark.base_root, "*") ).map{ |path| File.basename(path) }
    end
    
    themes.each do |name|
      target   = ThemePark.compiled_path(name)
      paths    = [/(?:\/|\\|\A)#{name}\.(css|js)$/]
      compiler = Sprockets::StaticCompiler.new(env, target, paths)
      compiler.compile
    end 

  end

end