# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "theme_park/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name             = "theme_park"
  s.version          = ThemePark::Version::STRING
  s.authors          = ["Thierry Zires"]
  s.email            = ["zshuaibin@gmail.com"]
  s.homepage         = "http://github.com/zires/theme_park"
  s.summary          = "Multiple theme plugin for rails3, sinatra, and more..."
  s.description      = "theme_park is a flexible multiple theme plugin for rails3, sinatra, and more...it's rack based"
  s.date             = %q{2012-03-15}
  s.extra_rdoc_files = ["LICENSE.txt", "README.rdoc"]

  s.files            = Dir["{app,config,db,lib}/**/*"] + ["LICENSE.txt", "Rakefile", "README.rdoc"]
  s.test_files       = Dir["test/**/*"]
  s.require_paths    = [%q{lib}]
  s.licenses         = [%q{MIT}]

  s.add_dependency "activesupport", ">= 3.1"
  s.add_dependency "rack"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "yard", "~> 0.7"
  s.add_development_dependency "bundler", "~> 1.0.0"
  s.add_development_dependency "minitest"
  s.add_development_dependency "turn"
  s.add_development_dependency "rails", ">= 3.1"

end
